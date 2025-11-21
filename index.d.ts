import type { JQuery } from 'jquery';

export interface LicenseDefinition {
  name: string;
  priority: number;
  available: boolean;
  url?: string;
  description?: string;
  categories: string[];
  labels?: string[];
  cssClass?: string;
  template?: (el: JQuery<HTMLElement>, license: LicenseDefinition, select: () => void) => void;
}

export interface LicenseSelectorOptions {
  appendTo?: string | HTMLElement | JQuery;
  start?: string;
  showLabels?: boolean;
  licenseItemTemplate?: (el: JQuery<HTMLElement>, license: LicenseDefinition, select: () => void) => void;
  licenses?: Record<string, Partial<LicenseDefinition>>;
  questions?: Record<string, unknown>;
  onLicenseSelected?: (license: LicenseDefinition) => void;
}

declare global {
  interface JQuery {
    licenseSelector(options?: LicenseSelectorOptions): JQuery;
  }
}

export default function createLicenseSelector(container: JQuery, options?: LicenseSelectorOptions): void;
