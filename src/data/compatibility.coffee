Y = true
N = false

LicenseCompatibility =
  columns:              ['cc-public-domain', 'mit', 'bsd-2c', 'bsd-3c', 'apache-2', 'lgpl-2.1', 'lgpl-2.1+', 'lgpl-3', 'mpl-2', 'epl-1', 'cddl-1', 'gpl-2', 'gpl-2+', 'gpl-3', 'agpl-1', 'agpl-3']
  table:
    'cc-public-domain': [ Y,                  Y,     Y,        Y,        Y,          Y,          Y,           Y,        Y,       Y,       Y,        Y,       Y,        Y,       Y,        Y      ]
    'mit':              [ N,                  Y,     Y,        Y,        Y,          Y,          Y,           Y,        Y,       Y,       Y,        Y,       Y,        Y,       Y,        Y      ]
    'bsd-2c':           [ N,                  N,     Y,        Y,        Y,          Y,          Y,           Y,        Y,       Y,       Y,        Y,       Y,        Y,       Y,        Y      ]
    'bsd-3c':           [ N,                  N,     N,        Y,        Y,          Y,          Y,           Y,        Y,       Y,       Y,        Y,       Y,        Y,       Y,        Y      ]
    'apache-2':         [ N,                  N,     N,        N,        Y,          N,          N,           Y,        Y,       Y,       N,        N,       N,        Y,       N,        Y      ]
    'lgpl-2.1':         [ N,                  N,     N,        N,        N,          Y,          N,           N,        Y,       N,       N,        Y,       N,        N,       Y,        N      ]
    'lgpl-2.1+':        [ N,                  N,     N,        N,        N,          N,          Y,           Y,        Y,       N,       N,        Y,       Y,        Y,       Y,        Y      ]
    'lgpl-3':           [ N,                  N,     N,        N,        N,          N,          N,           Y,        Y,       N,       N,        N,       N,        Y,       N,        Y      ]
    'mpl-2':            [ N,                  N,     N,        N,        N,          Y,          Y,           Y,        Y,       N,       N,        Y,       Y,        Y,       Y,        Y      ]
    'epl-1':            [ N,                  N,     N,        N,        N,          N,          N,           N,        Y,       Y,       Y,        N,       N,        Y,       N,        Y      ]
    'cddl-1':           [ N,                  N,     N,        N,        N,          N,          N,           N,        N,       N,       Y,        N,       N,        N,       N,        N      ]
    'gpl-2':            [ N,                  N,     N,        N,        N,          N,          N,           N,        N,       N,       N,        Y,       N,        N,       Y,        N      ]
    'gpl-2+':           [ N,                  N,     N,        N,        N,          N,          N,           N,        N,       N,       N,        Y,       Y,        Y,       Y,        Y      ]
    'gpl-3':            [ N,                  N,     N,        N,        N,          N,          N,           N,        N,       N,       N,        N,       Y,        Y,       N,        Y      ]
    'agpl-1':           [ N,                  N,     N,        N,        N,          N,          N,           N,        N,       N,       N,        N,       N,        N,       Y,        N      ]
    'agpl-3':           [ N,                  N,     N,        N,        N,          N,          N,           N,        N,       N,       N,        N,       N,        N,       N,        Y      ]

module.exports = LicenseCompatibility
