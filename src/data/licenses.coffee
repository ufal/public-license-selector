LicenseDefinitions =
  'cc-public-domain':
    name: 'Public Domain Mark (PD)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/publicdomain/mark/1.0/'
    description: "The work identified as being free of known restrictions under copyright law, including all related and neighboring rights."
    categories: ['public', 'data', 'software', 'public-domain']
    labels: ['public', 'pd']

  'cc-zero':
    name: 'Public Domain Dedication (CC Zero)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/publicdomain/zero/1.0/'
    description: 'CC Zero enables scientists, educators, artists and other creators and owners of copyright- or database-protected content to waive those interests in their works and thereby place them as completely as possible in the public domain, so that others may freely build upon, enhance and reuse the works for any purposes without restriction under copyright or database law.'
    categories: ['public', 'data', 'public-domain']
    labels: ['public', 'cc', 'zero', 'opendata']

  'pddl':
    name: 'Open Data Commons Public Domain Dedication and License (PDDL)'
    priority: 1
    available: false
    url: 'http://opendatacommons.org/licenses/pddl/summary/'
    description: 'This license is meant to be an international, database-specific equivalent of the public domain. You cannot relicense or sublicense any database under this license because, like the public domain, after dedication you no longer own any rights to the database.'
    categories: ['public', 'data', 'public-domain']
    labels: ['public']

  'cc-by':
    name: 'Creative Commons Attribution (CC-BY)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by/4.0/'
    description: 'This is the standard creative commons license that gives others maximum freedom to do what they want with your work.'
    categories: ['public', 'data', 'by']
    labels: ['public', 'cc', 'by', 'opendata']

  'odc-by':
    name: 'Open Data Commons Attribution License (ODC-By)'
    priority: 1
    available: false
    url: 'http://opendatacommons.org/licenses/by/summary/'
    description: ''
    categories: ['public', 'data', 'by']
    labels: ['public']

  'cc-by-sa':
    name: 'Creative Commons Attribution-ShareAlike (CC-BY-SA)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-sa/4.0/'
    description: 'This creative commons license is very similar to the regular Attribution license, but requires you to release all derivative works under this same license.'
    categories: ['public', 'data', 'by', 'sa']
    labels: ['public', 'cc', 'by', 'sa', 'opendata']

  'odbl':
    name: 'Open Data Commons Open Database License (ODbL)'
    priority: 1
    available: false
    url: 'http://opendatacommons.org/licenses/odbl/summary/'
    description: 'A copyleft license used by OpenStreetMap and others with very specific terms designed for databases.'
    categories: ['public', 'data', 'by', 'sa']
    labels: ['public']

  'cc-by-nd':
    name: 'Creative Commons Attribution-NoDerivs (CC-BY-ND)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-nd/4.0/'
    description: 'The no derivatives creative commons license is straightforward; you can take a work released under this license and re-distribute it but you cannot change it.'
    categories: ['public', 'data', 'by', 'nd']
    labels: ['public', 'cc', 'nd']

  'cc-by-nc':
    name: 'Creative Commons Attribution-NonCommercial (CC-BY-NC)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-nc/4.0/'
    description: 'A creative commons license that bans commercial use.'
    categories: ['public', 'data', 'by', 'nc']
    labels: ['public', 'cc', 'nc']

  'cc-by-nc-sa':
    name: 'Creative Commons Attribution-NonCommercial-ShareAlike (CC-BY-NC-SA)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-nc-sa/4.0/'
    description: 'A creative commons license that bans commercial use and requires you to release any modified works under this license.'
    categories: ['public', 'data', 'by', 'nc', 'sa']
    labels: ['public', 'cc', 'by', 'nc', 'sa']

  'cc-by-nc-nd':
    name: 'Creative Commons Attribution-NonCommercial-NoDerivs (CC-BY-NC-ND)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-nc-nd/4.0/'
    description: 'The most restrictive creative commons license. This only allows people to download and share your work for no commercial gain and for no other purposes.'
    categories: ['public', 'data', 'by', 'nc', 'nd']
    labels: ['public', 'cc', 'by', 'nc', 'nd']

  'perl-artistic-1':
    name: 'Artistic License 1.0'
    priority: 7
    available: true
    url: 'http://opensource.org/licenses/Artistic-Perl-1.0'
    description: 'NOTE: This license has been superseded by the Artistic License, Version 2.0. This is a license for software packages with the intent of giving the original copyright holder some measure of control over his software while still remaining open source. It is flexible and allows you to distribute or sell modified versions as long as you fulfill one of various conditions. Look at section 4 in the full text for a better explanation.'
    categories: ['public', 'software', 'perl']
    labels: ['public', 'perl']

  'perl-artistic-2':
    name: 'Artistic License 2.0'
    priority: 8
    available: true
    url: 'http://opensource.org/licenses/Artistic-2.0'
    description: 'This is a license for software packages with the intent of giving the original copyright holder some measure of control over his software while still remaining open source. It is flexible and allows you to distribute or sell modified versions as long as you fulfill one of various conditions. Look at section 4 in the full text for a better explanation.'
    categories: ['public', 'software', 'perl']
    labels: ['public', 'perl', 'osi']

  'gpl-2+':
    name: 'GNU General Public License 2 or later (GPL-2.0)'
    priority: 10
    available: true
    url: 'http://opensource.org/licenses/GPL-2.0'
    description: 'You may copy, distribute and modify the software as long as you track changes/dates of in source files and keep all modifications under GPL. You can distribute your application using a GPL library commercially, but you must also disclose the source code.'
    categories: ['public', 'software', 'gpl', 'copyleft', 'strong']
    labels: ['public', 'gpl', 'copyleft']

  'gpl-2':
    name: 'GNU General Public License 2 (GPL-2.0)'
    priority: 10
    available: false
    url: 'http://opensource.org/licenses/GPL-2.0'
    description: 'Standard GNU GPL version 2 but without support for later versions i.e. you cannot relicense under GPL 3.'
    categories: ['public', 'software', 'gpl', 'copyleft', 'strong']
    labels: ['public', 'gpl', 'copyleft']

  'gpl-3':
    name: 'GNU General Public License 3 (GPL-3.0)'
    priority: 11
    available: true
    url: 'http://opensource.org/licenses/GPL-3.0'
    description: 'You may copy, distribute and modify the software as long as you track changes/dates of in source files and keep modifications under GPL. You can distribute your application using a GPL library commercially, but you must also provide the source code. GPL 3 tries to close some loopholes in GPL 2.'
    categories: ['public', 'software', 'gpl', 'copyleft', 'strong']
    labels: ['public', 'gpl3', 'copyleft']

  'agpl-1':
    name: 'Affero General Public License 1 (AGPL-1.0)'
    priority: 50
    available: false
    url: 'http://www.affero.org/oagpl.html'
    description: ''
    categories: ['public', 'software', 'agpl', 'copyleft', 'strong']
    labels: ['public', 'copyleft']

  'agpl-3':
    name: 'Affero General Public License 3 (AGPL-3.0)'
    priority: 51
    available: true
    url: 'http://opensource.org/licenses/AGPL-3.0'
    description: 'The AGPL license differs from the other GNU licenses in that it was built for network software. You can distribute modified versions if you keep track of the changes and the date you made them. As per usual with GNU licenses, you must license derivatives under AGPL. It provides the same restrictions and freedoms as the GPLv3 but with an additional clause which makes it so that source code must be distributed along with web publication. Since web sites and services are never distributed in the traditional sense, the AGPL is the GPL of the web.'
    categories: ['public', 'software', 'agpl', 'copyleft', 'strong']
    labels: ['public', 'agpl3', 'copyleft']

  'mpl-2':
    name: 'Mozilla Public License 2.0'
    priority: 1
    available: true
    url: 'http://opensource.org/licenses/MPL-2.0'
    description: 'This is a lenient license used by the Mozilla Corporation that allows you a variety of explicit freedoms with the software so long as you keep modifications under this license and distribute the original source code alongside executables. It is a good midway license; it isn’t very strict and has only straightforward requirements.'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'mozilla', 'copyleft']

  'lgpl-2.1+':
    name: 'GNU Library or "Lesser" General Public License 2.1 or later (LGPL-2.1)'
    priority: 2
    available: true
    url: 'http://opensource.org/licenses/LGPL-2.1'
    description: 'You may copy, distribute and modify the software provided that modifications are described inside the modified files and licensed for free under LGPL-2.1. Derivatives or non-separate (statically-linked) works of the software must be licensed under LGPL, but separate, parent projects don\'t have to be.'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'lgpl', 'copyleft']

  'lgpl-2.1':
    name: 'GNU Library or "Lesser" General Public License 2.1 (LGPL-2.1)'
    priority: 2
    available: false
    url: 'http://opensource.org/licenses/LGPL-2.1'
    description: 'Standard GNU LGPL version 2.1 but without support for later versions i.e. you cannot relicense under LGPL 3.'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'lgpl', 'copyleft']

  'lgpl-3':
    name: 'GNU Library or "Lesser" General Public License 3.0 (LGPL-3.0)'
    priority: 3
    available: true
    url: 'http://opensource.org/licenses/LGPL-3.0'
    description: 'You may copy, distribute and modify the software provided that modifications are described inside the modified files and licensed for free under LGPL-2.1.  Derivatives or non-separate (statically-linked) works of the software must be licensed under LGPL, but separate, parent projects don\'t have to be. LGPL 3 tries to close some loopholes in LGPL 2.1.'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'lgpl3', 'copyleft']

  'epl-1':
    name: 'Eclipse Public License 1.0 (EPL-1.0)'
    priority: 4
    available: true
    url: 'http://opensource.org/licenses/EPL-1.0'
    description: 'This license, made and used by the Eclipse Foundation, isn’t all too stringent and gives both copyright and explicit patent rights. Check the full text of the license to see how liability is accorded.'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'eclipse', 'copyleft']

  'cddl-1':
    name: 'Common Development and Distribution License (CDDL-1.0)'
    priority: 5
    available: true
    url: 'http://opensource.org/licenses/CDDL-1.0'
    description: 'This is a very permissive and popular license made by Sun Microsystems that also includes explicit patent grants. It is relatively simplistic in its conditions, requiring only a small amount of documentation for redistribution (applying to source as well as modified code).'
    categories: ['public', 'software', 'copyleft', 'weak']
    labels: ['public', 'copyleft', 'osi']

  'mit':
    name: 'The MIT License (MIT)'
    priority: 1
    available: true
    url: 'http://opensource.org/licenses/mit-license.php'
    description: 'A short, permissive software license. Basically, you can do whatever you want as long as you include the original copyright and license.'
    categories: ['public', 'software', 'permissive']
    labels: ['public', 'mit', 'osi']

  'bsd-3c':
    name: 'The BSD 3-Clause "New" or "Revised" License (BSD)'
    priority: 2
    available: true
    url: 'http://opensource.org/licenses/BSD-3-Clause'
    description: 'The BSD 3-clause license allows you almost unlimited freedom with the software so long as you include the BSD copyright notice in it. "Use trademark" in this case means you cannot use the names of the original company or its members to endorse derived products.'
    categories: ['public', 'software', 'permissive']
    labels: ['public', 'bsd', 'osi']

  'bsd-2c':
    name: 'The BSD 2-Clause "Simplified" or "FreeBSD" License'
    priority: 3
    available: true
    url: 'http://opensource.org/licenses/BSD-2-Clause'
    description: 'The BSD 2-clause license allows you almost unlimited freedom with the software so long as you include the BSD copyright notice in it.'
    categories: ['public', 'software', 'permissive']
    labels: ['public', 'bsd', 'osi']

  'apache-2':
    name: 'Apache License 2'
    priority: 4
    available: true
    url: 'http://www.apache.org/licenses/LICENSE-2.0'
    description: 'A license that allows you much freedom with the software, including an explicit right to a patent. "State changes" means that you have to include a notice in each file you modified. '
    categories: ['public', 'software', 'permissive']
    labels: ['public', 'apache', 'osi']

module.exports = LicenseDefinitions
