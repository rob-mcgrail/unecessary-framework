# While true, throws proper errors. When nil, errors run the Error#bug controller
SETTINGS[:development_mode] = false

# The name of the site - used in title template helper
SETTINGS[:sitename] = 'name'

# url of the site
SETTINGS[:hostname] = 'name.com'

# GA tracking code, used in the ga_tracking template helper
SETTINGS[:ga_caode] = 'UA-XXXXX'

# Secret for salting things.
SETTINGS[:secret] = 'change_this_to_something'

# Database connection
SETTINGS[:db] = 'sqlite://' + PATH + '/db/main'

# The base template - this should lay out everything up to and including <body>, then yield
SETTINGS[:app_layout] = 'layouts/application'

# Where the public folders live
SETTINGS[:public_root] = 'public'

# The public folders - best not to change these as the template helpers assume they exist as below
SETTINGS[:public_folders] = ['/audio', '/files', '/images', '/javascript', '/stylesheets', '/video', '/tmp', '/robots.txt']

# Location of views. Slash on both sides, in app root.
SETTINGS[:view_folder] = '/views/'

# Chose coderay stylesheet (public/stylesheets/code/) - rack, idlecopy,
SETTINGS[:coderay_css] = 'idlecopy'

# Maximum bytes for the template chache (caches raw haml in memory to save on disk reads)
SETTINGS[:template_cache_max] = 1_000_000

# Maximum bytes for the hard chache (caches compiled html in memory to save on haml/db cycles)
SETTINGS[:hard_cache_max] = 1_000_000

