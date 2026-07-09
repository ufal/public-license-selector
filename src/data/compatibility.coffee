Y = true
N = false

###
# Module: data/compatibility.coffee
# Summary: Compatibility matrix used during the software flow to detect incompatible license mixes.
###
LicenseCompatibility =
  columns:              ['cc-public-domain', 'mit', 'bsd-2c', 'bsd-3c', 'apache-2', 'lgpl-2.1-only', 'lgpl-2.1-or-later', 'lgpl-3.0-only', 'mpl-2', 'epl-1', 'epl-2.0', 'cddl-1', 'gpl-2.0-only', 'gpl-2.0-or-later', 'gpl-3.0-only', 'agpl-1.0-only', 'agpl-2.0-only', 'agpl-2.0-or-later', 'agpl-3.0-only']
  table:
    'cc-public-domain': [ Y,                  Y,     Y,        Y,        Y,          Y,               Y,                   Y,              Y,       Y,       Y,         Y,         Y,             Y,                 Y,            Y,              Y,              Y,                   Y              ]
    'mit':              [ N,                  Y,     Y,        Y,        Y,          Y,               Y,                   Y,              Y,       Y,       Y,         Y,         Y,             Y,                 Y,            Y,              Y,              Y,                   Y              ]
    'bsd-2c':           [ N,                  N,     Y,        Y,        Y,          Y,               Y,                   Y,              Y,       Y,       Y,         Y,         Y,             Y,                 Y,            Y,              Y,              Y,                   Y              ]
    'bsd-3c':           [ N,                  N,     N,        Y,        Y,          Y,               Y,                   Y,              Y,       Y,       Y,         Y,         Y,             Y,                 Y,            Y,              Y,              Y,                   Y              ]
    'apache-2':         [ N,                  N,     N,        N,        Y,          N,               N,                   Y,              Y,       Y,       Y,         N,         N,             N,                 Y,            N,              N,              Y,                   Y              ]
    'lgpl-2.1-only':    [ N,                  N,     N,        N,        N,          Y,               N,                   N,              Y,       N,       N,         N,         Y,             N,                 N,            Y,              N,              N,                   N              ]
    'lgpl-2.1-or-later':[ N,                  N,     N,        N,        N,          N,               Y,                   Y,              Y,       N,       N,         N,         Y,             Y,                 Y,            Y,              Y,              Y,                   Y              ]
    'lgpl-3.0-only':    [ N,                  N,     N,        N,        N,          N,               N,                   Y,              Y,       N,       N,         N,         N,             N,                 Y,            N,              N,              Y,                   Y              ]
    'mpl-2':            [ N,                  N,     N,        N,        N,          Y,               Y,                   Y,              Y,       N,       N,         N,         Y,             Y,                 Y,            Y,              Y,              Y,                   Y              ]
    'epl-1':            [ N,                  N,     N,        N,        N,          N,               N,                   N,              Y,       Y,       Y,         Y,         N,             N,                 Y,            N,              N,              Y,                   Y              ]
    # REVIEW: verify compatibility values with domain expert
    'epl-2.0':          [ N,                  N,     N,        N,        N,          N,               N,                   N,              Y,       Y,       Y,         Y,         N,             N,                 Y,            N,              N,              Y,                   Y              ]
    'cddl-1':           [ N,                  N,     N,        N,        N,          N,               N,                   N,              N,       N,       Y,         Y,         N,             N,                 N,            N,              N,              N,                   N              ]
    'gpl-2.0-only':     [ N,                  N,     N,        N,        N,          N,               N,                   N,              N,       N,       N,         N,         Y,             N,                 N,            Y,              N,              N,                   N              ]
    'gpl-2.0-or-later': [ N,                  N,     N,        N,        N,          N,               N,                   N,              N,       N,       N,         N,         Y,             Y,                 Y,            Y,              Y,              Y,                   Y              ]
    'gpl-3.0-only':     [ N,                  N,     N,        N,        N,          N,               N,                   N,              N,       N,       N,         N,         N,             Y,                 Y,            N,              N,              Y,                   Y              ]
    'agpl-1.0-only':    [ N,                  N,     N,        N,        N,          N,               N,                   N,              N,       N,       N,         N,         N,             N,                 N,            Y,              N,              N,                   N              ]
    # REVIEW: verify compatibility values with domain expert
    'agpl-2.0-only':    [ N,                  N,     N,        N,        N,          N,               N,                   N,              N,       N,       N,         N,         N,             N,                 N,            N,              Y,              N,                   N              ]
    # REVIEW: verify compatibility values with domain expert
    'agpl-2.0-or-later':[ N,                  N,     N,        N,        N,          N,               N,                   N,              N,       N,       N,         N,         N,             N,                 N,            Y,              Y,              Y,                   Y              ]
    'agpl-3.0-only':    [ N,                  N,     N,        N,        N,          N,               N,                   N,              N,       N,       N,         N,         N,             N,                 N,            N,              N,              Y,                   Y              ]

# Old key aliases (backward compatibility)
LicenseCompatibility.table['gpl-2'] = LicenseCompatibility.table['gpl-2.0-only']
LicenseCompatibility.table['gpl-2+'] = LicenseCompatibility.table['gpl-2.0-or-later']
LicenseCompatibility.table['gpl-3'] = LicenseCompatibility.table['gpl-3.0-only']
LicenseCompatibility.table['lgpl-2.1'] = LicenseCompatibility.table['lgpl-2.1-only']
LicenseCompatibility.table['lgpl-2.1+'] = LicenseCompatibility.table['lgpl-2.1-or-later']
LicenseCompatibility.table['lgpl-3'] = LicenseCompatibility.table['lgpl-3.0-only']
LicenseCompatibility.table['agpl-1'] = LicenseCompatibility.table['agpl-1.0-only']
LicenseCompatibility.table['agpl-3'] = LicenseCompatibility.table['agpl-3.0-only']

module.exports = LicenseCompatibility
