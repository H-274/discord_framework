import interaction/application_command
import interaction/message_component
import interaction/modal_submit
import interaction/ping

pub type Interaction {
  Ping(ping.Interaction)
  ApplicationCommand(application_command.Interaction)
  ApplicationCommandAutocomplete(application_command.Interaction)
  MessageComponent(message_component.Interaction)
  ModalSubmit(modal_submit.Interaction)
}
