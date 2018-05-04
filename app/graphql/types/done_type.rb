Types::DoneType = GraphQL::ObjectType.define do
  name "Done"
  field :text, types.String
  field :created_at, types.String
  field :updated_at, types.String
end
