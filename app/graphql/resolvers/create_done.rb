class Resolvers::CreateDone < GraphQL::Function
  argument :text, !types.String
  argument :date, !types.String

  type Types::DoneType

  def call(_obj, args, _ctx)
    Done.create!(
      text: args[:text],
      date: args[:date],
    )
  end
end
