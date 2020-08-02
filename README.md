# OrderJob Elixir Test

### To run the task

> mix process

### To run the tests

> mix test

---

## Comentários

- Os dados que vem da API externa está simulado através de um arquivo `.json` dentro de `./external/`
- Existem dois agentes externos para interagir com os dados, por motivos de testes e acoplamento, foi usado o **Repository Pattern** junto com o recurso de **Protocols** da linguagem, que nos permite inserir as dependências em um **Container** o que torna bem prático a mockagem das respostas e chamadas de cada serviço

- O service **ProcessingService** é o responsável de realmente traduzir e validar os dados entre uma `Order` e uma `ProcessedOrder`
- Para a validação dos campos obrigatórios e mapeamento das models foi usado a lib **Ecto**
- O arquivo `index.ex` é o starting point da aplicação, ali é definido o container de dependência global e os metodos que devem ser chamados para chegar na resposta final (ele se comunica diretamente com o repositório que recebe os dados de uma nova **Order** e não com um service, pois não foi necessário criar uma camada a mais para tratar regras específicas em relação ao dado de entrada, visto que validações genéricas dos campos são feitos na camada de model)
- Visto a simplicidade do problema não foi necessário utilizar nenhuma framework além do próprio `mix`
- Existem dois testes em `test/integration_test.exs` que estão chamando a API original e de fato fazendo uma requisição HTTP

## Problemas que tive

- Não achei uma boa maneira de tipar o retorno das funções com `@spec` pois boa parte delas possuem retorno que são structs que retornam Models do Ecto, se eu colocasse o nome do Model, o ElixirLS reclamava que a implementação da função não era coerente com o retorno estipulado no `@spec`, se não iria estar certo, não vi sentido em deixar o `@spec` com generics tipo `any()` ou `map()`
