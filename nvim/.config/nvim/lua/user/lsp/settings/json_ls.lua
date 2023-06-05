return {
    on_setup = function(server)
        server.setup({
            settings = {
                json = {
                    schema = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        })
    end,
}
