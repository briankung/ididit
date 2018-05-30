Types::DoneType = GraphQL::ObjectType.define do
  name 'Done'

  field :id, !types.ID
  field :text, !types.String
  field :date, !types.String
  field :created_at, !types.String
  field :updated_at, !types.String
end
