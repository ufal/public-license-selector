import { LicenseCompatibility } from './compatibility'

export interface HistoryState {
  question?: string
  questionText?: string
  licenses: unknown[]
  finished?: boolean
  answer?: string
  answers?: unknown[]
  options?: Array<{ licenses: unknown[]; selected: boolean }>
}

export interface LicenseSelector {
  readonly licenses: Record<string, { name: string; key?: string }>
  readonly licensesList: { update: (licenses: unknown[]) => void }
  goto(where: string, safeState?: boolean): void
  question(text: string): void
  answer(text: string, action: () => void, disabled?: () => boolean): void
  yes(action: () => void): void
  no(action: () => void): void
  option(licenses: string[], action?: () => void): void
  license(...choices: (string | string[])[]): void
  cantlicense(reason: string): void
  has(category: string): boolean
  only(category: string): boolean
  hasnt(category: string): boolean
  include(category: string): void
  exclude(category: string): void
  hasAnyOptionSelected(): boolean
  getSelectedLicenseKeys(): string[]
  _getSelectedAction(): (() => void) | undefined
}

function runSelectedAction(sel: LicenseSelector): void {
  const action = sel._getSelectedAction()
  if (action) action()
}

export const QuestionDefinitions: Record<string, (sel: LicenseSelector) => void> = {
  KindOfContent(sel) {
    sel.question('What do you want to deposit?')
    sel.answer('Software', () => {
      sel.exclude('data')
      sel.goto('YourSoftware')
    })
    sel.answer('Data', () => {
      sel.exclude('software')
      sel.goto('DataCopyrightable')
    })
  },

  DataCopyrightable(sel) {
    sel.question('Is your data within the scope of copyright and related rights?')
    sel.yes(() => sel.goto('OwnIPR'))
    sel.no(() => sel.license('cc-public-domain'))
  },

  OwnIPR(sel) {
    sel.question('Do you own copyright and similar rights in your dataset and all its constitutive parts?')
    sel.yes(() => sel.goto('AllowDerivativeWorks'))
    sel.no(() => sel.goto('EnsureLicensing'))
  },

  AllowDerivativeWorks(sel) {
    sel.question('Do you allow others to make derivative works?')
    sel.yes(() => {
      sel.exclude('nd')
      sel.goto('ShareAlike')
    })
    sel.no(() => {
      sel.include('nd')
      if (sel.only('nc')) {
        sel.license()
      } else {
        sel.goto('CommercialUse')
      }
    })
  },

  ShareAlike(sel) {
    sel.question('Do you require others to share derivative works based on your data under a compatible license?')
    sel.yes(() => {
      sel.include('sa')
      if (sel.only('nc')) {
        sel.license()
      } else {
        sel.goto('CommercialUse')
      }
    })
    sel.no(() => {
      sel.exclude('sa')
      if (sel.only('nc')) {
        sel.license()
      } else {
        sel.goto('CommercialUse')
      }
    })
  },

  CommercialUse(sel) {
    sel.question('Do you allow others to make commercial use of you data?')
    sel.yes(() => {
      sel.exclude('nc')
      if (sel.only('by')) {
        sel.license()
      } else {
        sel.goto('DecideAttribute')
      }
    })
    sel.no(() => {
      sel.include('nc')
      sel.include('by')
      sel.license()
    })
  },

  DecideAttribute(sel) {
    sel.question('Do you want others to attribute your data to you?')
    sel.yes(() => {
      sel.include('by')
      sel.license()
    })
    sel.no(() => {
      sel.include('public-domain')
      sel.license()
    })
  },

  EnsureLicensing(sel) {
    sel.question('Are all the elements of your dataset licensed under a public license or in the Public Domain?')
    sel.yes(() => sel.goto('LicenseInteropData'))
    sel.no(() => sel.cantlicense('You need additional permission before you can deposit the data!'))
  },

  LicenseInteropData(sel) {
    sel.question('Choose licenses present in your dataset:')
    sel.option(['cc-public-domain', 'cc-zero', 'pddl'], () => sel.goto('AllowDerivativeWorks'))
    sel.option(['cc-by', 'odc-by'], () => {
      sel.exclude('public-domain')
      sel.goto('AllowDerivativeWorks')
    })
    sel.option(['cc-by-nc'], () => {
      sel.include('nc')
      sel.goto('AllowDerivativeWorks')
    })
    sel.option(['cc-by-nc-sa'], () => sel.license('cc-by-nc-sa'))
    sel.option(['odbl'], () => sel.license('odbl', 'cc-by-sa'))
    sel.option(['cc-by-sa'], () => sel.license('cc-by-sa'))
    sel.option(['cc-by-nd', 'cc-by-nc-nd'], () => {
      sel.cantlicense("License doesn't allow derivative works. You need additional permission before you can deposit the data!")
    })

    sel.answer('Next', () => runSelectedAction(sel), () => !sel.hasAnyOptionSelected())
  },

  YourSoftware(sel) {
    sel.question('Is your code based on existing software or is it your original work?')
    sel.answer('Based on existing software', () => sel.goto('LicenseInteropSoftware'))
    sel.answer('My own code', () => sel.goto('Copyleft'))
  },

  LicenseInteropSoftware(sel) {
    for (const license of LicenseCompatibility.columns) {
      sel.option([license])
    }

    sel.answer('Next', () => {
      const licenses = sel.getSelectedLicenseKeys()

      if (licenses.length === 0) return

      // Check compatibility matrix
      for (const license1 of licenses) {
        const index1 = LicenseCompatibility.columns.indexOf(license1)
        for (const license2 of licenses) {
          const index2 = LicenseCompatibility.columns.indexOf(license2)
          if (!LicenseCompatibility.table[license2][index1] || !LicenseCompatibility.table[license1][index2]) {
            sel.cantlicense(
              `The licenses <strong>${license1}</strong> and <strong>${license2}</strong> in your software are incompatible. Contact the copyright owner and try to talk them into re-licensing.`
            )
            return
          }
        }
      }

      // Intersect compatibility sets
      let list: boolean[] | null = null
      for (const key of licenses) {
        const idx = LicenseCompatibility.columns.indexOf(key)
        const compatRow = LicenseCompatibility.table[key]
        if (list === null) {
          list = [...compatRow]
          continue
        }
        list = list.map((val, i) => compatRow[i] && val)
      }

      const resultKeys: string[] = []
      if (list) {
        for (let i = 0; i < list.length; i++) {
          if (list[i]) {
            resultKeys.push(LicenseCompatibility.columns[i])
          }
        }
      }

      sel.licensesList.update(resultKeys)

      if (sel.has('copyleft') && sel.has('permissive')) {
        sel.goto('Copyleft')
      } else if (sel.has('copyleft') && sel.has('strong') && sel.has('weak')) {
        sel.goto('StrongCopyleft')
      } else {
        sel.license()
      }
    }, () => !sel.hasAnyOptionSelected())
  },

  Copyleft(sel) {
    sel.question('Do you require others who modify your code to release it under a compatible licence?')
    sel.yes(() => {
      sel.include('copyleft')
      if (sel.has('weak') && sel.has('strong')) {
        sel.goto('StrongCopyleft')
      } else {
        sel.license()
      }
    })
    sel.no(() => {
      sel.exclude('copyleft')
      sel.include('permissive')
      sel.license()
    })
  },

  StrongCopyleft(sel) {
    sel.question('Is your code used directly as an executable or are you licensing a library (your code will be linked)?')
    sel.answer('Executable', () => {
      sel.include('strong')
      sel.license()
    })
    sel.answer('Library', () => {
      sel.include('weak')
      sel.license()
    })
  },
}
