import ui from './ui.json';
import localeConfig from '../config/locales.json';

export const defaultLocale = localeConfig.defaultLocale;
export const locales = Object.keys(localeConfig.locales);
export const nonDefaultLocales = locales.filter((l) => l !== defaultLocale);

export type UIKey = keyof typeof ui.en;

type Dictionary = Partial<Record<UIKey, string>>;

/** Returns a lookup that falls back to English for untranslated keys. */
export function useTranslations(lang: string) {
	const dictionary = ((ui as Record<string, Dictionary>)[lang] ?? ui.en) as Dictionary;
	return (key: UIKey): string => dictionary[key] || ui.en[key];
}

/** Prefixes a root-relative path with the locale segment for non-default locales. */
export function localizePath(lang: string, path: string): string {
	return lang === defaultLocale ? path : `/${lang}${path}`;
}

/** `getStaticPaths` result for `[lang]` routes. */
export function localeStaticPaths() {
	return nonDefaultLocales.map((lang) => ({ params: { lang } }));
}

/** Fills `{name}` placeholders in a translated string. */
export function format(template: string, values: Record<string, string | number>): string {
	return template.replace(/\{(\w+)\}/g, (match, key) => (key in values ? String(values[key]) : match));
}

/** Locale-aware number formatting (e.g. 15,640 / 15.640 / 15 640). */
export function formatNumber(lang: string, value: number): string {
	return new Intl.NumberFormat(lang).format(value);
}

/** Rounds down to a stable public figure, e.g. 38,422 -> "38,000+". */
export function formatAtLeast(lang: string, value: number): string {
	const step = value >= 10_000 ? 1000 : value >= 1000 ? 100 : 1;
	const rounded = Math.floor(value / step) * step;
	return rounded < value ? `${formatNumber(lang, rounded)}+` : formatNumber(lang, rounded);
}
