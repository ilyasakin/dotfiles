local wk = require("which-key")

-- Register navigation actions
wk.register({
    p = {
        name = "Navigation",
        v = "Netrw",
        f = "Telescope",
        s = "Grep"
    }
},
{ prefix = "<leader>"  })
