import interaction/application_command/chat_input
import interaction/application_command/message
import interaction/application_command/user

pub type Interaction {
  ChatInputInteraction(chat_input.Interaction)
  MessageInteraction(message.Interaction)
  UserInteraction(user.Interaction)
}

pub type ApplicationCommand {
  ChatInputCommand(chat_input.Command)
  MessageCommand(message.Command)
  UserCommand(user.Command)
}
