###
# Module: data/licenses.coffee
# Summary: Master list of license definitions consumed by the selector and compatibility logic.
###
LicenseDefinitions =
  'cc-public-domain':
    name: 'Public Domain Mark (PD)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/publicdomain/mark/1.0/'
    description: 'The work has been identified as being free of known restrictions under copyright law, including all related and neighbouring rights.'
    categories: ['public', 'data', 'software', 'public-domain']
    labels: ['public', 'pd']

  'cc-zero':
    name: 'Public Domain Dedication (CC Zero)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/publicdomain/zero/1.0/'
    description: 'By attaching CC0 license, the author waives all copyright in the work and, to the extent allowed by law, dedicates the work to the public domain.'
    categories: ['public', 'data', 'public-domain']
    labels: ['public', 'cc', 'zero', 'opendata']

  'pddl':
    name: 'Open Data Commons Public Domain Dedication and License (PDDL)'
    priority: 1
    available: false
    url: 'http://opendatacommons.org/licenses/pddl/summary/'
    # TODO: verify description – not in approved docx
    description: 'This license is meant to be an international, database-specific equivalent of the public domain. You cannot relicense or sublicense any database under this license because, like the public domain, after dedication you no longer own any rights to the database.'
    categories: ['public', 'data', 'public-domain']
    labels: ['public']

  'cc-by':
    name: 'Creative Commons Attribution 4.0 (CC BY 4.0)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by/4.0/'
    description: 'Creative Commons license that gives users maximum freedom to use the work – they can use the work in any way, as long as they give appropriate credit, provide link to this license, and indicate if changes were made.'
    categories: ['public', 'data', 'by']
    labels: ['public', 'cc', 'by', 'opendata']

  'odc-by':
    name: 'Open Data Commons Attribution License (ODC-By)'
    priority: 1
    available: false
    url: 'http://opendatacommons.org/licenses/by/summary/'
    # TODO: verify description – not in approved docx
    description: ''
    categories: ['public', 'data', 'by']
    labels: ['public']

  'cc-by-sa':
    name: 'Creative Commons Attribution-ShareAlike 4.0 (CC BY-SA 4.0)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-sa/4.0/'
    description: 'This Creative Commons license is similar to the regular CC BY license but requires you to share all new works built upon the licensed material under this license.'
    categories: ['public', 'data', 'by', 'sa']
    labels: ['public', 'cc', 'by', 'sa', 'opendata']

  'odbl':
    name: 'Open Data Commons Open Database License (ODbL)'
    priority: 1
    available: false
    url: 'http://opendatacommons.org/licenses/odbl/summary/'
    # TODO: verify description – not in approved docx
    description: 'A copyleft license used by OpenStreetMap and others with very specific terms designed for databases.'
    categories: ['public', 'data', 'by', 'sa']
    labels: ['public']

  'cc-by-nd':
    name: 'Creative Commons Attribution-NoDerivatives 4.0 (CC BY-ND 4.0)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-nd/4.0/'
    description: 'This license allows users to use the work in any way but prohibits the user from further sharing of derivative works (new works created by processing of the licensed work, e.g. a translation). Works that have not been modified can be shared provided attribution is given.'
    categories: ['public', 'data', 'by', 'nd']
    labels: ['public', 'cc', 'nd']

  'cc-by-nc':
    name: 'Creative Commons Attribution-NonCommercial 4.0 (CC BY-NC 4.0)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-nc/4.0/'
    description: 'This Creative Commons license allows the work to be used in any way, provided that it is not used commercially.'
    categories: ['public', 'data', 'by', 'nc']
    labels: ['public', 'cc', 'nc']

  'cc-by-nc-sa':
    name: 'Creative Commons Attribution-NonCommercial-ShareAlike 4.0 (CC BY-NC-SA 4.0)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-nc-sa/4.0/'
    description: 'This license allows the user to share the licensed work but prohibits the user from using the work commercially and requires the user to share any new works built upon the licensed material under this license.'
    categories: ['public', 'data', 'by', 'nc', 'sa']
    labels: ['public', 'cc', 'by', 'nc', 'sa']

  'cc-by-nc-nd':
    name: 'Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 (CC BY-NC-ND 4.0)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-nc-nd/4.0/'
    description: 'The most restrictive Creative Commons license. It allows the user to share the licensed work but prohibits the user from further sharing of derivative works (new works created by processing of the licensed work, e.g. a translation) and/or from using the work commercially.'
    categories: ['public', 'data', 'by', 'nc', 'nd']
    labels: ['public', 'cc', 'by', 'nc', 'nd']

  'perl-artistic-1':
    name: 'Artistic License 1.0'
    priority: 7
    available: true
    url: 'http://opensource.org/licenses/Artistic-Perl-1.0'
    # TODO: verify description – not in approved docx
    description: 'NOTE: This license has been superseded by the Artistic License, Version 2.0. This is a license for software packages with the intent of giving the original copyright holder some measure of control over his software while still remaining open source. It is flexible and allows you to distribute or sell modified versions as long as you fulfill one of various conditions. Look at section 4 in the full text for a better explanation.'
    categories: ['public', 'software', 'perl']
    labels: ['public', 'perl']

  'perl-artistic-2':
    name: 'Artistic License 2.0'
    priority: 8
    available: true
    url: 'http://opensource.org/licenses/Artistic-2.0'
    description: 'This permissive license allows users to copy and modify the licensed software package. Users can distribute (gratis or for a fee) the unmodified software without any restrictions, provided that they duplicate all of the original copyright notices and associated disclaimers. In case users want to distribute (gratis or for a fee) the modified software, they must abide by terms of Article 4 (see full text of the license for explanation).'
    categories: ['public', 'software', 'perl']
    labels: ['public', 'perl', 'osi']

  'gpl-2.0-or-later':
    name: 'GNU General Public License 2.0 or later (GPL-2.0-or-later)'
    priority: 10
    available: true
    url: 'http://opensource.org/licenses/GPL-2.0'
    description: 'Strong copyleft license that allows users to copy, distribute and modify the software as long as they track changes/dates of in source files and keep all modifications (derivatives) under GPL. Users can distribute their software using a GPL library commercially, but they must also disclose the source code.'
    categories: ['public', 'software', 'gpl', 'copyleft', 'strong']
    labels: ['public', 'gpl', 'copyleft']
    versionConstraint: 'flexible'
    versionFamily: 'gpl'

  'gpl-2.0-only':
    name: 'GNU General Public License 2.0 only (GPL-2.0-only)'
    priority: 10
    available: true
    url: 'http://opensource.org/licenses/GPL-2.0'
    description: 'Strong copyleft license that allows users to copy, distribute and modify the software as long as they track changes/dates of in source files and keep all modifications (derivatives) under GPL. Users can distribute their software using a GPL library commercially, but they must also disclose the source code.'
    categories: ['public', 'software', 'gpl', 'copyleft', 'strong']
    labels: ['public', 'gpl', 'copyleft']
    versionConstraint: 'fixed'
    versionFamily: 'gpl'

  'gpl-3.0-only':
    name: 'GNU General Public License 3.0 only (GPL-3.0-only)'
    priority: 11
    available: true
    url: 'http://opensource.org/licenses/GPL-3.0'
    description: 'Strong copyleft license that allows users to copy, distribute and modify the software as long as they track changes/dates of in source files and keep modifications (derivatives) under GPL. Users can distribute their application using a GPL library commercially, but they must also provide the source code. GPL-3.0 tries to close some loopholes in version 2.0.'
    categories: ['public', 'software', 'gpl', 'copyleft', 'strong']
    labels: ['public', 'gpl3', 'copyleft']
    versionConstraint: 'fixed'
    versionFamily: 'gpl'

  'agpl-1.0-only':
    name: 'Affero General Public License 1.0 only (AGPL-1.0-only)'
    priority: 50
    available: true
    url: 'http://www.affero.org/oagpl.html'
    # TODO: verify description – not in approved docx
    description: 'Strong copyleft license that applies to network software and requires derivatives to remain under AGPL terms.'
    categories: ['public', 'software', 'agpl', 'copyleft', 'strong']
    labels: ['public', 'copyleft']
    versionConstraint: 'fixed'
    versionFamily: 'agpl'

  'agpl-2.0-only':
    name: 'Affero General Public License 2.0 only (AGPL-2.0-only)'
    priority: 50
    available: true
    url: 'https://www.gnu.org/licenses/agpl-3.0.en.html'
    link: 'https://www.gnu.org/licenses/agpl-3.0.en.html'
    icon: 'agpl'
    summary: 'Strong copyleft network software license with fixed version constraint.'
    # TODO: verify description – not in approved docx
    description: 'Strong copyleft license for network software that requires derivatives to remain under AGPL-2.0-only terms.'
    categories: ['public', 'software', 'agpl', 'copyleft', 'strong']
    labels: ['public', 'copyleft']
    versionConstraint: 'fixed'
    versionFamily: 'agpl'

  'agpl-2.0-or-later':
    name: 'Affero General Public License 2.0 or later (AGPL-2.0-or-later)'
    priority: 50
    available: true
    url: 'https://www.gnu.org/licenses/agpl-3.0.en.html'
    link: 'https://www.gnu.org/licenses/agpl-3.0.en.html'
    icon: 'agpl'
    summary: 'Strong copyleft network software license with flexible version constraint.'
    # TODO: verify description – not in approved docx
    description: 'Strong copyleft license for network software that allows redistribution and derivatives under AGPL-2.0-or-later terms.'
    categories: ['public', 'software', 'agpl', 'copyleft', 'strong']
    labels: ['public', 'copyleft']
    versionConstraint: 'flexible'
    versionFamily: 'agpl'

  'agpl-3.0-only':
    name: 'Affero General Public License 3.0 only (AGPL-3.0-only)'
    priority: 51
    available: true
    url: 'http://opensource.org/licenses/AGPL-3.0'
    description: 'The AGPL license is a strong copyleft license used for web applications (SaaS). Users can distribute modified versions of the software as long as they keep track of the changes and the date they made them. As per usual with GNU licenses, users must license derivatives under AGPL. It provides the same restrictions and freedoms as the GPL-3.0 but with an additional clause which makes it so that source code must be distributed along with web publication.'
    categories: ['public', 'software', 'agpl', 'copyleft', 'strong']
    labels: ['public', 'agpl3', 'copyleft']
    versionConstraint: 'fixed'
    versionFamily: 'agpl'

  'mpl-2':
    name: 'Mozilla Public License 2.0'
    priority: 1
    available: true
    url: 'http://opensource.org/licenses/MPL-2.0'
    description: 'Weak-copyleft license that allows a variety of explicit freedoms with the software as long as any modifications to the files under this license are shared under the same license and the original source code is distributed alongside executables.'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'mozilla', 'copyleft']

  'lgpl-2.1-or-later':
    name: 'GNU Library or Lesser General Public License 2.1 or later (LGPL-2.1-or-later)'
    priority: 2
    available: true
    url: 'http://opensource.org/licenses/LGPL-2.1'
    description: 'Weak copyleft license that allows users to copy, distribute and modify the software provided that modifications (derivatives) are described inside the modified files and licensed under LGPL-2.1. In the case of statically linked libraries under LGPL 2.1, the software must comply with the license terms, such as providing object code for relinking. These requirements may not apply to dynamically linked libraries.'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'lgpl', 'copyleft']
    versionConstraint: 'flexible'
    versionFamily: 'lgpl'

  'lgpl-2.1-only':
    name: 'GNU Library or Lesser General Public License 2.1 only (LGPL-2.1-only)'
    priority: 2
    available: true
    url: 'http://opensource.org/licenses/LGPL-2.1'
    description: 'Weak copyleft license that allows users to copy, distribute and modify the software provided that modifications (derivatives) are described inside the modified files and licensed under LGPL-2.1. In the case of statically linked libraries under LGPL 2.1, the software must comply with the license terms, such as providing object code for relinking. These requirements may not apply to dynamically linked libraries.'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'lgpl', 'copyleft']
    versionConstraint: 'fixed'
    versionFamily: 'lgpl'

  'lgpl-3.0-only':
    name: 'GNU Library or Lesser General Public License 3.0 only (LGPL-3.0-only)'
    priority: 3
    available: true
    url: 'http://opensource.org/licenses/LGPL-3.0'
    description: 'Weak copyleft license that allows users to copy, distribute and modify the software provided that modifications (derivatives) are described inside the modified files and licensed under LGPL-3.0.  In the case of statically linked libraries under LGPL 3.0, the software must comply with the license terms, such as providing object code for relinking. These requirements may not apply to dynamically linked libraries. LGPL-3.0 tries to close some loopholes in version 2.1.'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'lgpl3', 'copyleft']
    versionConstraint: 'fixed'
    versionFamily: 'lgpl'

  'epl-1':
    name: 'Eclipse Public License 1.0 (EPL-1.0)'
    priority: 4
    available: true
    url: 'http://opensource.org/licenses/EPL-1.0'
    description: 'Weak copyleft license, that allows users to modify and share the EPL licensed software, while requiring that any changes to the software (derivatives) be shared under the same license. The license is governed by the laws of the State of New York and the intellectual property laws of the United States of America.'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'eclipse', 'copyleft']

  'epl-2.0':
    name: 'Eclipse Public License 2.0 (EPL-2.0)'
    priority: 4
    available: true
    url: 'https://opensource.org/license/epl-2-0'
    link: 'https://opensource.org/license/epl-2-0'
    icon: 'epl'
    summary: 'Weak copyleft license with optional GPL compatibility via secondary licensing.'
    description: 'Weak copyleft license that allows users to modify and share the EPL licensed software, while requiring that any changes to the software be shared under the same license. Unlike version 1.0, it can be compatible with the GPL - provided that you make the software available under a secondary license.'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'eclipse', 'copyleft']

  'cddl-1':
    name: 'Common Development and Distribution License (CDDL-1.0)'
    priority: 5
    available: true
    url: 'http://opensource.org/licenses/CDDL-1.0'
    description: 'It is a weak copyleft license that allows users to modify and distribute the licensed software, provided that any modifications of the original version are shared under the same license. It also includes explicit patent grants (which is lost if the patented feature of the software is modified in any way).'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'copyleft', 'osi']

  'mit':
    name: 'The MIT License (MIT)'
    priority: 1
    available: true
    url: 'http://opensource.org/licenses/mit-license.php'
    description: 'A permissive software license. The user can use the MIT licensed software in any way (e.g. copy, modify, merge, publish, distribute, sublicense, and/or sell copies) provided that all copies or substantial portions of the software include a copyright notice and copy of the terms of the MIT license.'
    categories: ['public', 'software', 'permissive']
    labels: ['public', 'mit', 'osi']

  'bsd-3c':
    name: 'The 3-Clause BSD License (New or Revised BSD License)'
    priority: 2
    available: true
    url: 'http://opensource.org/licenses/BSD-3-Clause'
    description: 'The BSD 3-clause is a permissive license that allows users almost unlimited freedom with the software so long as they include the BSD copyright notice in it. However, users cannot use the names of copyright holders to promote products derived from the software.'
    categories: ['public', 'software', 'permissive']
    labels: ['public', 'bsd', 'osi']

  'bsd-2c':
    name: 'The 2-Clause BSD License (Simplified or FreeBSD License)'
    priority: 3
    available: true
    url: 'http://opensource.org/licenses/BSD-2-Clause'
    description: 'The BSD 2-clause is a permissive license that allows users almost unlimited freedom with the software so long as they include the BSD copyright notice in it.'
    categories: ['public', 'software', 'permissive']
    labels: ['public', 'bsd', 'osi']

  'apache-2':
    name: 'Apache License 2'
    priority: 4
    available: true
    url: 'http://www.apache.org/licenses/LICENSE-2.0'
    description: 'A permissive software license. The user can use the software in any way provided that the modified software includes a copyright notice, a copy of the license terms and modified files include notices stating that the files have been modified.'
    categories: ['public', 'software', 'permissive']
    labels: ['public', 'apache', 'osi']

# Old key aliases (backward compatibility)
LicenseDefinitions['gpl-2'] = LicenseDefinitions['gpl-2.0-only']
LicenseDefinitions['gpl-2+'] = LicenseDefinitions['gpl-2.0-or-later']
LicenseDefinitions['gpl-3'] = LicenseDefinitions['gpl-3.0-only']
LicenseDefinitions['lgpl-2.1'] = LicenseDefinitions['lgpl-2.1-only']
LicenseDefinitions['lgpl-2.1+'] = LicenseDefinitions['lgpl-2.1-or-later']
LicenseDefinitions['lgpl-3'] = LicenseDefinitions['lgpl-3.0-only']
LicenseDefinitions['agpl-1'] = LicenseDefinitions['agpl-1.0-only']
LicenseDefinitions['agpl-3'] = LicenseDefinitions['agpl-3.0-only']

module.exports = LicenseDefinitions
