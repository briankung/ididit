Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createDone, function: Resolvers::CreateDone.new
end
