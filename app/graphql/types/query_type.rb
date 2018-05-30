Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :allDones, !types[Types::DoneType] do
    description "All the dones, ever"

    resolve ->(obj, args, ctx) {
      Done.all
    }
  end
end
