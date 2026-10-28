// Supported hardware, derived at build time from the same targets.json the app
// bundles (assets/targets.json, kept current by .github/workflows/update_targets.yml)
// plus field verification from src/data/verified.json (scripts/build_verified.py).
import targetsJson from '../../../assets/targets.json';
import verified from './verified.json';

interface Target {
	product_name: string;
	platform: string;
	upload_methods: string[];
}

type Vendor = { name: string } & Record<string, Record<string, Target> | string>;

export type DeviceRole = 'rx' | 'tx';
export type DeviceBand = '2400' | '900' | 'dual';

export interface Device {
	name: string;
	brand: string;
	role: DeviceRole;
	band: DeviceBand;
	chip: string;
	verified: boolean;
}

const verifiedNames = new Set(verified.targets);

/** ESP targets with Wi-Fi upload are what the app can flash over the air. */
const isWifiFlashable = (t: Target) => t.upload_methods.includes('wifi') && t.platform.startsWith('esp');

export const devices: Device[] = Object.values(targetsJson as unknown as Record<string, Vendor>)
	.flatMap((vendor) =>
		Object.entries(vendor)
			.filter((entry): entry is [string, Record<string, Target>] => typeof entry[1] === 'object')
			.flatMap(([category, targets]) => {
				const [role, band] = category.split('_') as [DeviceRole, DeviceBand];
				return Object.values(targets)
					.filter(isWifiFlashable)
					.map((t) => ({
						name: t.product_name,
						brand: vendor.name,
						role,
						band,
						chip: t.platform.toUpperCase(),
						verified: verifiedNames.has(t.product_name),
					}));
			})
	)
	.sort((a, b) => a.brand.localeCompare(b.brand) || a.name.localeCompare(b.name));

/** Devices grouped by brand, in brand order. */
export const devicesByBrand: [string, Device[]][] = [
	...devices.reduce((groups, d) => groups.set(d.brand, [...(groups.get(d.brand) ?? []), d]), new Map<string, Device[]>()),
];

export const chipsets = [...new Set(devices.map((d) => d.chip))].sort();

export const hardwareStats = {
	devices: devices.length,
	brands: devicesByBrand.length,
	verified: devices.filter((d) => d.verified).length,
	flashes: verified.totalSuccessfulFlashes,
};

if (import.meta.env.DEV) {
	const known = new Set(devices.map((d) => d.name));
	const stale = verified.targets.filter((name) => !known.has(name));
	if (stale.length) console.warn(`[hardware] verified.json names not in targets.json: ${stale.join(', ')}`);
}
