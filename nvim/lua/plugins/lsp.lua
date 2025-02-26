-- LSP Plugins
return {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            -- Mason must be loaded before its dependents so we need to set it up here.
            { 'williamboman/mason.nvim', opts = {} },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            { 'j-hui/fidget.nvim',       opts = {} },

            -- Allows extra capabilities provided by nvim-cmp
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            --  This function gets run when an LSP attaches to a particular buffer.
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    -- This function lets us more easily define mappings specific
                    -- for LSP related items. It sets the mode, buffer and description for us each time.
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func,
                            { buffer = event.buf, desc = 'LSP: ' .. desc, noremap = true, silent = true })
                    end

                    -- Jump to the definition of the word under your cursor.
                    --  This is where a variable was first declared, or where a function is defined, etc.
                    --  To jump back, press <C-t>.
                    map('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
                    map('gD', vim.lsp.buf.definition, '[g]oto [D]eclaration')
                    map('gr', vim.lsp.buf.references, '[g]oto [r]eferences')
                    map('gi', vim.lsp.buf.implementation, '[g]oto [i]mplementation')
                    map('K', vim.lsp.buf.hover, '[K]Hover')
                    map('<A-k>', vim.lsp.buf.signature_help, '[<A-k>]Signature Help')
                    map('<leader>h', vim.lsp.buf.document_highlight,
                        'Document [H]ighlighting - Highlight related symbol under cursor')
                    -- map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[w]orkspace folder [a]dd')
                    -- map('<leader>wr', vim.lsp.buf.add_workspace_folder, '[w]orkspace folder [r]emove')
                    -- map('<leader>wl', vim.lsp.buf.list_workspace_folders, '[w]orkspace folder [l]ist')
                    -- map('<leader>D', vim.lsp.buf.type_definition, 'type [D]efinition')
                    -- map('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
                    map('<leader>rn', require("nvchad.lsp.renamer"), '[r]e[n]ame')
                    map('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction', { 'n', 'x' })
                    map('<leader>cf', vim.lsp.buf.format, '[c]ode [f]ormatting')
                    map('<leader>ds', vim.diagnostic.open_float, '[d]iagnostic [s]how in float')
                    map('<leader>dq', vim.diagnostic.setloclist, '[d]iagnostic [q]set')
                    map('[d', vim.diagnostic.goto_prev, '[d]iagnostic prev[')
                    map(']d', vim.diagnostic.goto_next, '[d]iagnostic next]')


                    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                    local function client_supports_method(client, method, bufnr)
                        if vim.fn.has 'nvim-0.11' == 1 then
                            return client:supports_method(method, bufnr)
                        else
                            return client.supports_method(method, { bufnr = bufnr })
                        end
                    end

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                        local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                        -- vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        --   buffer = event.buf,
                        --   group = highlight_augroup,
                        --   callback = vim.lsp.buf.document_highlight,
                        -- })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end

                    -- The following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- This may be unwanted, since they displace some of your code
                    -- if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    --   map('<leader>th', function()
                    --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    --   end, '[T]oggle Inlay [H]ints')
                    -- end
                end,
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts
            vim.diagnostic.config {
                severity_sort = true,
                float = { source = 'if_many' },
                underline = false,
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '',
                        [vim.diagnostic.severity.WARN] = '',
                        [vim.diagnostic.severity.INFO] = '',
                        [vim.diagnostic.severity.HINT] = '',
                    },
                } or {},
                virtual_text = {
                    source = 'if_many',
                    spacing = 2,
                    severity = vim.diagnostic.severity.WARN,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            }

            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP specification.
            --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local servers = {
                -- pylsp = {},
                -- ccls = {},
                clangd = {},
                vimls = {},
                pyright = {},

                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                            diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
                stylua = {},
                bashls = {},
                shellcheck = {}
            }

            -- Ensure the servers and tools above are installed
            --
            --
            -- Add other tools here that you want Mason to install
            -- for you, so that they are available from within Neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }
            require('mason-lspconfig').setup {
                ensure_installed = {}, -- explicitly set to an empty table (populated via mason-tool-installer instead)
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for ts_ls)
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end,
    },
}
