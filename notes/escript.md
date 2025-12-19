
# Escript

- **escript** 是 Elixir/Erlang 提供的一种将 Elixir 项目打包为可执行脚本（单一文件）的机制。
- 适用于命令行工具、脚本型应用等，用户无需安装依赖即可运行（只需有 Erlang）。

### 工作原理

- escript 会将你的 Elixir 代码、依赖的 BEAM 字节码（.beam 文件）和启动入口打包成一个文件。
- 运行时，Erlang 的 `escript` 工具会解包并启动指定的模块和函数（通常是 `main/1`）。

### 结构与入口

- 入口模块需实现 `main/1` 函数，接收命令行参数（字符串列表）。
- 入口在 `mix.exs` 的 `escript: [main_module: MyModule]` 指定。

### 开发与调试

- 在 `mix.exs` 添加 `escript` 配置。
- 使用 `mix escript.build` 生成可执行文件。
- 直接运行：`./your_script arg1 arg2`
- 调试：可用 `IO.inspect/2`、`IO.puts/2` 等打印调试。

### 深入源码与机制

- escript 实际上是一个特殊格式的 zip 文件，包含 `.beam` 文件和元数据。
- 可以用 `unzip` 命令解包，查看内部结构。
- [Erlang escript code](https://github.com/erlang/otp/blob/master/lib/stdlib/src/escript.erl) 
- [mix escript.build](https://github.com/elixir-lang/elixir/blob/main/lib/mix/lib/mix/tasks/escript.build.ex)。
