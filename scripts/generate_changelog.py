#!/usr/bin/env python3
import os
import subprocess
import sys
import json
import urllib.request

def run_git_command(args):
    try:
        result = subprocess.run(args, capture_output=True, text=True, check=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Error running git command {' '.join(args)}: {e.stderr}", file=sys.stderr)
        return None

def main():
    api_key = os.environ.get("GEMINI_API_KEY") or os.environ.get("ARB_TRANSLATE_API_KEY")
    if not api_key:
        print("Error: GEMINI_API_KEY or ARB_TRANSLATE_API_KEY environment variable is not set.", file=sys.stderr)
        print("Please export your API key first, e.g.: export GEMINI_API_KEY='your-key'", file=sys.stderr)
        sys.exit(1)

    # 1. Determine revision range
    base_branch = "main"
    # Check if 'main' exists locally
    has_local_main = subprocess.run(["git", "show-ref", "--verify", "--quiet", "refs/heads/main"]).returncode == 0
    if not has_local_main:
        base_branch = "origin/main"

    current_branch = run_git_command(["git", "branch", "--show-current"])
    
    if current_branch in ["main", "master"]:
        # If already on main, compare against the last tag to find release diff
        last_tag = run_git_command(["git", "describe", "--tags", "--abbrev=0"])
        if last_tag:
            revision_range = f"{last_tag}..HEAD"
            print(f"On main branch. Fetching commits since last tag ({last_tag})...")
        else:
            revision_range = "HEAD~10..HEAD"
            print("On main branch with no tags. Defaulting to the last 10 commits...")
        version_title = last_tag or "Release"
    else:
        # Otherwise, compare current dev branch against main/origin-main
        revision_range = f"{base_branch}..HEAD"
        print(f"Comparing current branch ({current_branch}) against base branch ({base_branch})...")
        # Try to guess version title from describe or use branch name
        version_title = run_git_command(["git", "describe", "--tags", "--always"]) or current_branch

    commits = run_git_command(["git", "log", revision_range, "--oneline"])

    if not commits:
        print(f"No new commits found in range: {revision_range}")
        sys.exit(0)

    print(f"\nAnalyzing commits:\n{commits}\n")

    # 2. Build prompt
    prompt = f"""You are an expert technical writer and product manager for the ExpressLRS Mobile App (a Flutter app used to configure and flash ExpressLRS hardware).

Below is the git commit log of changes made to the app since the last release.
Please write a human-readable, user-friendly changelog that explains the practical effects of these changes.

Guidelines:
- Do NOT use technical jargon (e.g. avoid talking about specific Riverpod providers, ref.invalidate, Dio interceptors, build runner, or code files).
- Group the changes into logical sections: "New Features", "Bug Fixes", "Improvements".
- Under each bullet point, clearly state what the change does and how it practically affects the user (e.g. instead of 'Fix targetIpProvider reset', say 'The app now correctly detects when you disconnect from your drone's Wi-Fi hotspot, allowing you to download firmware updates over your home internet without getting stuck offline.').
- Keep the tone helpful, clear, and focused on the user experience.
- Output ONLY the markdown content of the changelog. Do not include markdown code block formatting (like ```markdown) around the response.

Commit Log:
{commits}
"""

    # 3. Call Gemini API
    url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key={api_key}"
    payload = {
        "contents": [{
            "parts": [{"text": prompt}]
        }]
    }

    req = urllib.request.Request(
        url,
        data=json.dumps(payload).encode("utf-8"),
        headers={"Content-Type": "application/json"},
        method="POST"
    )

    try:
        with urllib.request.urlopen(req) as response:
            res_body = response.read().decode("utf-8")
            res_json = json.loads(res_body)
            text = res_json["candidates"][0]["content"]["parts"][0]["text"]
            
            # Get current date
            date_str = run_git_command(["date", "+%Y-%m-%d"]) or "2026-07-07"
            
            # Format output
            changelog_content = f"## [{version_title}] - {date_str}\n\n{text.strip()}\n"
            
            print("\n=== GENERATED CHANGELOG ===\n")
            print(changelog_content)
            
            # Prepend to existing CHANGELOG.md
            changelog_file = "CHANGELOG.md"
            existing_content = ""
            if os.path.exists(changelog_file):
                with open(changelog_file, "r") as f:
                    existing_content = f.read()
            
            with open(changelog_file, "w") as f:
                f.write(changelog_content)
                if existing_content:
                    f.write("\n")
                    f.write(existing_content)
            
            print(f"Changelog successfully prepended to {changelog_file}!")
            print("Please review the file and make any manual modifications before committing.")
                
    except Exception as e:
        print(f"Error calling Gemini API: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
