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
