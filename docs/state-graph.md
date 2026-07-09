# License Selector State Graph

> **Auto-generated documentation** - Run `npm run generate-graph` to update

## Overview

This document visualizes the decision tree used by the Public License Selector. The selector guides users through a series of questions to recommend appropriate licenses for their software or data.

## Complete State Graph

```mermaid
%%{init: {'theme':'base', 'themeVariables': { 'fontSize':'16px'}, 'flowchart':{'curve':'basis', 'padding':20}}}%%
flowchart TD
    Start([Start]) --> KindOfContent

    KindOfContent{"What do you want to deposit?"}
    DataCopyrightable(["Is your data within the scope of copyright
and/or special right of the database maker?"])
    class DataCopyrightable dataPath
    AllOriginalWork{"Is everything in the dataset your original
work?"}
    class AllOriginalWork dataPath
    AllowDerivativeWorks{"Do you allow others to make derivative works?"}
    class AllowDerivativeWorks dataPath
    ShareAlike{"Do you require others to share derivative
works based on your data under the same
license?"}
    class ShareAlike dataPath
    CommercialUse(["Do you allow others to use your data
commercially?"])
    class CommercialUse dataPath
    ThirdPartyPublic(["Is the third party content of the dataset
licensed under a public license or in the
public domain?"])
    class ThirdPartyPublic dataPath
    MadeChanges{"Have you made any changes to the third party
content of the dataset?"}
    class MadeChanges dataPath
    ThirdPartyLicense(["Under which license was the third party
content that you changed licensed?"])
    class ThirdPartyLicense dataPath
    ThirdPartyNCDerivatives(["Do you allow others to make derivative works?"])
    class ThirdPartyNCDerivatives dataPath
    ThirdPartyNCShareAlike(["Do you require others to share derivative
works based on your data under the same
license?"])
    class ThirdPartyNCShareAlike dataPath
    YourSoftware["Is your software based on existing code or is
it all your original work?"]
    class YourSoftware softwarePath
    ModifyingExisting(["Are you modifying the existing software or is
the existing software only being used as a
part of your larger work?"])
    class ModifyingExisting softwarePath
    LicenseInteropSoftware(["Select licenses in your code:"])
    class LicenseInteropSoftware softwarePath
    Copyleft(["Do you require others who use your code in
their software to release it under a
compatible open-source license?"])
    class Copyleft softwarePath
    StrongCopyleft(["Do you require others to use a compatible
license for the software as a whole or only
for the parts that modified your code?"])
    class StrongCopyleft softwarePath

    KindOfContent -->YourSoftware
    KindOfContent -->DataCopyrightable
    DataCopyrightable -->|"Yes"| AllOriginalWork
    AllOriginalWork -->|"Yes"| AllowDerivativeWorks
    AllOriginalWork -->|"No"| ThirdPartyPublic
    AllowDerivativeWorks -->ShareAlike
    AllowDerivativeWorks -->CommercialUse
    ShareAlike -->CommercialUse
    ThirdPartyPublic -->|"Yes"| MadeChanges
    MadeChanges -->|"Yes"| ThirdPartyLicense
    MadeChanges -->|"No"| AllowDerivativeWorks
    ThirdPartyLicense -->|"Public Domain or CC Zero"| AllowDerivativeWorks
    ThirdPartyLicense -->|"CC BY-NC"| ThirdPartyNCDerivatives
    ThirdPartyNCDerivatives -->|"Yes"| ThirdPartyNCShareAlike
    YourSoftware -->|"Based on existing software"| ModifyingExisting
    YourSoftware -->|"My own code"| Copyleft
    ModifyingExisting -->|"Modifying the existing software"| LicenseInteropSoftware
    LicenseInteropSoftware -->|"Option selected"| Copyleft
    LicenseInteropSoftware -->|"Option selected"| StrongCopyleft
    Copyleft -->StrongCopyleft
    DataCopyrightable --> End([Select License])
    CommercialUse --> End([Select License])
    ThirdPartyLicense --> End([Select License])
    ThirdPartyNCDerivatives --> End([Select License])
    ThirdPartyNCShareAlike --> End([Select License])
    ModifyingExisting --> End([Select License])
    LicenseInteropSoftware --> End([Select License])
    Copyleft --> End([Select License])
    StrongCopyleft --> End([Select License])
    ThirdPartyPublic --> Error([Cannot License])
    ThirdPartyLicense --> Error([Cannot License])
    LicenseInteropSoftware --> Error([Cannot License])

    classDef dataPath fill:#e1f5ff,stroke:#01579b,stroke-width:2px,padding:15px,min-width:250px
    classDef softwarePath fill:#f3e5f5,stroke:#4a148c,stroke-width:2px,padding:15px,min-width:250px
    classDef terminalNode fill:#c8e6c9,stroke:#2e7d32,stroke-width:3px,padding:15px
    classDef errorNode fill:#ffcdd2,stroke:#c62828,stroke-width:3px,padding:15px
```

## Data Licensing Path

```mermaid
%%{init: {'theme':'base', 'themeVariables': { 'fontSize':'16px'}, 'flowchart':{'curve':'basis', 'padding':20}}}%%
flowchart TD
    Start([Start]) --> KindOfContent

    KindOfContent{"What do you want to deposit?"}
    DataCopyrightable(["Is your data within the scope of copyright
and/or special right of the database maker?"])
    class DataCopyrightable dataPath
    AllOriginalWork{"Is everything in the dataset your original
work?"}
    class AllOriginalWork dataPath
    AllowDerivativeWorks{"Do you allow others to make derivative works?"}
    class AllowDerivativeWorks dataPath
    ShareAlike{"Do you require others to share derivative
works based on your data under the same
license?"}
    class ShareAlike dataPath
    CommercialUse(["Do you allow others to use your data
commercially?"])
    class CommercialUse dataPath
    ThirdPartyPublic(["Is the third party content of the dataset
licensed under a public license or in the
public domain?"])
    class ThirdPartyPublic dataPath
    MadeChanges{"Have you made any changes to the third party
content of the dataset?"}
    class MadeChanges dataPath
    ThirdPartyLicense(["Under which license was the third party
content that you changed licensed?"])
    class ThirdPartyLicense dataPath
    ThirdPartyNCDerivatives(["Do you allow others to make derivative works?"])
    class ThirdPartyNCDerivatives dataPath
    ThirdPartyNCShareAlike(["Do you require others to share derivative
works based on your data under the same
license?"])
    class ThirdPartyNCShareAlike dataPath
    ModifyingExisting(["Are you modifying the existing software or is
the existing software only being used as a
part of your larger work?"])
    class ModifyingExisting softwarePath
    LicenseInteropSoftware(["Select licenses in your code:"])
    class LicenseInteropSoftware softwarePath
    Copyleft(["Do you require others who use your code in
their software to release it under a
compatible open-source license?"])
    class Copyleft softwarePath
    StrongCopyleft(["Do you require others to use a compatible
license for the software as a whole or only
for the parts that modified your code?"])
    class StrongCopyleft softwarePath

    KindOfContent -->DataCopyrightable
    DataCopyrightable -->|"Yes"| AllOriginalWork
    AllOriginalWork -->|"Yes"| AllowDerivativeWorks
    AllOriginalWork -->|"No"| ThirdPartyPublic
    AllowDerivativeWorks -->ShareAlike
    AllowDerivativeWorks -->CommercialUse
    ShareAlike -->CommercialUse
    ThirdPartyPublic -->|"Yes"| MadeChanges
    MadeChanges -->|"Yes"| ThirdPartyLicense
    MadeChanges -->|"No"| AllowDerivativeWorks
    ThirdPartyLicense -->|"Public Domain or CC Zero"| AllowDerivativeWorks
    ThirdPartyLicense -->|"CC BY-NC"| ThirdPartyNCDerivatives
    ThirdPartyNCDerivatives -->|"Yes"| ThirdPartyNCShareAlike
    ModifyingExisting -->|"Modifying the existing software"| LicenseInteropSoftware
    LicenseInteropSoftware -->|"Option selected"| Copyleft
    LicenseInteropSoftware -->|"Option selected"| StrongCopyleft
    Copyleft -->StrongCopyleft
    DataCopyrightable --> End([Select License])
    CommercialUse --> End([Select License])
    ThirdPartyLicense --> End([Select License])
    ThirdPartyNCDerivatives --> End([Select License])
    ThirdPartyNCShareAlike --> End([Select License])
    ModifyingExisting --> End([Select License])
    LicenseInteropSoftware --> End([Select License])
    Copyleft --> End([Select License])
    StrongCopyleft --> End([Select License])
    ThirdPartyPublic --> Error([Cannot License])
    ThirdPartyLicense --> Error([Cannot License])
    LicenseInteropSoftware --> Error([Cannot License])

    classDef dataPath fill:#e1f5ff,stroke:#01579b,stroke-width:2px,padding:15px,min-width:250px
    classDef softwarePath fill:#f3e5f5,stroke:#4a148c,stroke-width:2px,padding:15px,min-width:250px
    classDef terminalNode fill:#c8e6c9,stroke:#2e7d32,stroke-width:3px,padding:15px
    classDef errorNode fill:#ffcdd2,stroke:#c62828,stroke-width:3px,padding:15px
```

## Software Licensing Path

```mermaid
%%{init: {'theme':'base', 'themeVariables': { 'fontSize':'16px'}, 'flowchart':{'curve':'basis', 'padding':20}}}%%
flowchart TD
    Start([Start]) --> KindOfContent

    KindOfContent{"What do you want to deposit?"}
    DataCopyrightable(["Is your data within the scope of copyright
and/or special right of the database maker?"])
    class DataCopyrightable dataPath
    CommercialUse(["Do you allow others to use your data
commercially?"])
    class CommercialUse dataPath
    ThirdPartyPublic(["Is the third party content of the dataset
licensed under a public license or in the
public domain?"])
    class ThirdPartyPublic dataPath
    ThirdPartyLicense(["Under which license was the third party
content that you changed licensed?"])
    class ThirdPartyLicense dataPath
    ThirdPartyNCDerivatives(["Do you allow others to make derivative works?"])
    class ThirdPartyNCDerivatives dataPath
    ThirdPartyNCShareAlike(["Do you require others to share derivative
works based on your data under the same
license?"])
    class ThirdPartyNCShareAlike dataPath
    YourSoftware["Is your software based on existing code or is
it all your original work?"]
    class YourSoftware softwarePath
    ModifyingExisting(["Are you modifying the existing software or is
the existing software only being used as a
part of your larger work?"])
    class ModifyingExisting softwarePath
    LicenseInteropSoftware(["Select licenses in your code:"])
    class LicenseInteropSoftware softwarePath
    Copyleft(["Do you require others who use your code in
their software to release it under a
compatible open-source license?"])
    class Copyleft softwarePath
    StrongCopyleft(["Do you require others to use a compatible
license for the software as a whole or only
for the parts that modified your code?"])
    class StrongCopyleft softwarePath

    KindOfContent -->YourSoftware
    KindOfContent -->DataCopyrightable
    ThirdPartyLicense -->|"CC BY-NC"| ThirdPartyNCDerivatives
    ThirdPartyNCDerivatives -->|"Yes"| ThirdPartyNCShareAlike
    YourSoftware -->|"Based on existing software"| ModifyingExisting
    YourSoftware -->|"My own code"| Copyleft
    ModifyingExisting -->|"Modifying the existing software"| LicenseInteropSoftware
    LicenseInteropSoftware -->|"Option selected"| Copyleft
    LicenseInteropSoftware -->|"Option selected"| StrongCopyleft
    Copyleft -->StrongCopyleft
    DataCopyrightable --> End([Select License])
    CommercialUse --> End([Select License])
    ThirdPartyLicense --> End([Select License])
    ThirdPartyNCDerivatives --> End([Select License])
    ThirdPartyNCShareAlike --> End([Select License])
    ModifyingExisting --> End([Select License])
    LicenseInteropSoftware --> End([Select License])
    Copyleft --> End([Select License])
    StrongCopyleft --> End([Select License])
    ThirdPartyPublic --> Error([Cannot License])
    ThirdPartyLicense --> Error([Cannot License])
    LicenseInteropSoftware --> Error([Cannot License])

    classDef dataPath fill:#e1f5ff,stroke:#01579b,stroke-width:2px,padding:15px,min-width:250px
    classDef softwarePath fill:#f3e5f5,stroke:#4a148c,stroke-width:2px,padding:15px,min-width:250px
    classDef terminalNode fill:#c8e6c9,stroke:#2e7d32,stroke-width:3px,padding:15px
    classDef errorNode fill:#ffcdd2,stroke:#c62828,stroke-width:3px,padding:15px
```

## State Reference Table

| State | Question | Transitions | Type |
|-------|----------|-------------|------|
| KindOfContent | What do you want to deposit? | → YourSoftware<br>→ DataCopyrightable | Question |
| DataCopyrightable | Is your data within the scope of copyright and/or special right of the database maker? | → AllOriginalWork | ✅ Terminal |
| AllOriginalWork | Is everything in the dataset your original work? | → AllowDerivativeWorks<br>→ ThirdPartyPublic | Question |
| AllowDerivativeWorks | Do you allow others to make derivative works? | → ShareAlike<br>→ CommercialUse | Question |
| ShareAlike | Do you require others to share derivative works based on your data under the same license? | → CommercialUse<br>→ CommercialUse | Question |
| CommercialUse | Do you allow others to use your data commercially? | N/A | ✅ Terminal |
| ThirdPartyPublic | Is the third party content of the dataset licensed under a public license or in the public domain? | → MadeChanges | ❌ Error |
| MadeChanges | Have you made any changes to the third party content of the dataset? | → ThirdPartyLicense<br>→ AllowDerivativeWorks | Question |
| ThirdPartyLicense | Under which license was the third party content that you changed licensed? | → AllowDerivativeWorks<br>→ AllowDerivativeWorks<br>→ ThirdPartyNCDerivatives | ❌ Error |
| ThirdPartyNCDerivatives | Do you allow others to make derivative works? | → ThirdPartyNCShareAlike | ✅ Terminal |
| ThirdPartyNCShareAlike | Do you require others to share derivative works based on your data under the same license? | N/A | ✅ Terminal |
| YourSoftware | Is your software based on existing code or is it all your original work? | → ModifyingExisting<br>→ Copyleft | Question |
| ModifyingExisting | Are you modifying the existing software or is the existing software only being used as a part of your larger work? | → LicenseInteropSoftware | ✅ Terminal |
| LicenseInteropSoftware | Select licenses in your code: | → Copyleft<br>→ StrongCopyleft | ❌ Error (Conditional) |
| Copyleft | Do you require others who use your code in their software to release it under a compatible open-source license? | → StrongCopyleft | ✅ Terminal (Conditional) |
| StrongCopyleft | Do you require others to use a compatible license for the software as a whole or only for the parts that modified your code? | N/A | ✅ Terminal |


## Legend

- 🔹 **Blue nodes**: Data licensing path
- 🔸 **Purple nodes**: Software licensing path
- ✅ **Green nodes**: Terminal states (license selection)
- ❌ **Red nodes**: Error states (cannot license)
- ♦️ **Diamond shapes**: Yes/No decisions
- ⬜ **Rectangles**: Multi-option questions

## How to Update

1. Modify `src/data/questions.coffee`
2. Run `npm run generate-graph`
3. Review the updated diagrams in this file
4. Commit changes to version control

## Related Files

- **Question Definitions**: `src/data/questions.coffee`
- **License Data**: `src/data/licenses.coffee`
- **Compatibility Matrix**: `src/data/compatibility.coffee`
- **Generator Script**: `scripts/generate-state-graph.js`
- **Source Flowcharts**: `docs/license-selector-tree/LS_Flowchart_navrh_software_ENG.1 (1).pdf`, `LS_Flowchart_navrh_Data_ENG (4).pdf`
