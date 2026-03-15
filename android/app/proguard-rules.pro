# Proguard rules for Aptabase Flutter SDK
# Prevent R8/Proguard from stripping or obfuscating classes required by the analytics SDK.

-keep class io.aptabase.** { *; }
-keep interface io.aptabase.** { *; }

# Also keep Flutter plugin classes if they are being stripped
-keep class io.aptabase.aptabase_flutter.** { *; }
