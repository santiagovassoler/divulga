defmodule DivulgaWeb.Schema.Types do
    use Absinthe.Schema.Notation

    alias DivulgaWeb.Schema.Types

    import_types(Types.UserType)
end