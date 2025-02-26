import interaction.{type Interaction}
import interaction/application_command.{type ApplicationCommand}

pub type Bot {
  Bot(pub_key: String, commands: List(#(String, ApplicationCommand)))
}

pub type Success {
  Pong
}

pub type Failure {
  NotFound
}

pub fn handle_interaction(
  bot: Bot,
  interaction: Interaction,
) -> Result(Success, Failure) {
  todo
}
