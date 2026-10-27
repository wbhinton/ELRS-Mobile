// Content model for the landing page. Copy lives in src/i18n/ui.json (referenced
// by key); URLs live in src/config/site.ts.
import type { ImageMetadata } from 'astro';
import type { UIKey } from '../i18n';
import { links } from '../config/site';
import googlePlayBadge from '../assets/badges/google-play.png';
import appStoreBadge from '../assets/badges/app-store.svg';
import flashing from '../assets/screens/flashing.png';
import firmwareManager from '../assets/screens/firmware-manager.png';
import settings from '../assets/screens/settings.png';
import deviceConfig from '../assets/screens/device-config.png';

export { default as heroScreen } from '../assets/screens/dashboard.png';

export interface Store {
	id: string; // analytics `store` parameter
	href: string;
	label: UIKey;
	badge: ImageMetadata;
}

export const stores: Store[] = [
	{ id: 'google_play', href: links.googlePlay, label: 'hero.google_play', badge: googlePlayBadge },
	{ id: 'apple_app_store', href: links.appStore, label: 'hero.app_store', badge: appStoreBadge },
];

export const steps: { title: UIKey; body: UIKey }[] = [
	{ title: 'how.step1_title', body: 'how.step1_body' },
	{ title: 'how.step2_title', body: 'how.step2_body' },
	{ title: 'how.step3_title', body: 'how.step3_body' },
];

export const features: { image: ImageMetadata; title: UIKey; body: UIKey }[] = [
	{ image: flashing, title: 'features.flash_title', body: 'features.flash_body' },
	{ image: firmwareManager, title: 'features.cache_title', body: 'features.cache_body' },
	{ image: settings, title: 'features.profiles_title', body: 'features.profiles_body' },
	{ image: deviceConfig, title: 'features.config_title', body: 'features.config_body' },
];

export const useCases: { label: UIKey; title: UIKey; body: UIKey; fixTitle: UIKey; fixBody: UIKey }[] = [
	{
		label: 'why.problem_label',
		title: 'why.problem_title',
		body: 'why.problem_desc',
		fixTitle: 'why.problem_fix_title',
		fixBody: 'why.problem_fix_desc',
	},
	{
		label: 'why.updates_label',
		title: 'why.updates_title',
		body: 'why.updates_desc',
		fixTitle: 'why.updates_fix_title',
		fixBody: 'why.updates_fix_desc',
	},
];

export interface Video {
	id: string; // YouTube video ID
	title: string; // creator's own title, not translated
	body?: UIKey;
	vertical?: boolean;
}

export const demoVideo: Video = { id: 'v1gV7t4i-dA', title: 'ELRS Mobile flashing demo', vertical: true };

export const communityVideos: Video[] = [
	{ id: 'UqGi2g3P3Kw', title: 'Joshua Bardwell - Flash ELRS from your phone? OFFLINE!', body: 'videos.bardwell_desc' },
	{
		id: 'Dc9BJZtZLP8',
		title: 'Painless360 - ELRS Mobile: Update your ELRS device offline at the field using your phone!',
		body: 'videos.painless_desc',
	},
];

export const altInstalls: { href: string; title: UIKey; body: UIKey; track?: string }[] = [
	{ href: links.githubStore, title: 'get_started.github_store_title', body: 'get_started.github_store_desc' },
	{ href: links.directApk, title: 'get_started.apk_title', body: 'get_started.apk_desc', track: 'direct_apk' },
	{ href: links.repo, title: 'get_started.source_title', body: 'get_started.source_desc' },
];

// Interim until Phase 4 derives these from targets.json.
export const chipsets = ['ESP8285', 'ESP32', 'ESP32-C3', 'ESP32-S3'];
export const testedHardware = [
	'RadioMaster XR Series',
	'BetaFPV SuperP',
	'HappyModel ES900 / EP',
	'RadioMaster Nomad / Pocket',
];
