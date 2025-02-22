import gleam/dynamic.{type Dynamic}
import gleam/option.{type Option}

pub type Base {
  Base(
    id: String,
    application_id: String,
    guild: Option(Dynamic),
    guild_id: Option(String),
    channel: Option(Dynamic),
    channel_id: Option(String),
    member: Option(Dynamic),
    user: Option(Dynamic),
    token: String,
    version: Int,
    message: Option(Dynamic),
    app_permissions: String,
    locale: Option(String),
    guild_locale: Option(String),
    entitlements: List(Dynamic),
    authorizing_integration_owners: List(#(ApplicationIntegration, String)),
    context: Option(Context),
  )
}

pub type ApplicationIntegration {
  GuildInstall
  UserInstall
}

pub type Context {
  Guild
  BotDm
  PrivateChannel
}
