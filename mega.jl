using XLSX, DataFrames
using Dash, DashHtmlComponents, DashCoreComponents, DashTable
using HTTP
using Sockets

# meta = Dict("name"=>"viewport",
#         "content"=>"width=device-width, initial-scale=1.0")
# app = dash(meta_tags= meta)
app = dash()

app.layout = html_div() do
        html_h1("Hello Dash"),
        html_div("Dash.jl: Julia interface for Dash"),
        dcc_graph(
            id = "example-graph",
            figure = (
                data = [
                    (x = [1, 2, 3], y = [4, 1, 2], type = "bar", name = "SF"),
                    (x = [1, 2, 3], y = [2, 4, 5], type = "bar", name = "Montréal"),
                ],
                layout = (title = "Dash Data Visualization",)
            )
        )
    end

h = make_handler(app)

const ROUTER = HTTP.Router()
HTTP.@register(ROUTER, "GET", "/", h)
# run_server(app, "0.0.0.0", 8080)
HTTP.serve(ROUTER, Sockets.localhost, 8081)
