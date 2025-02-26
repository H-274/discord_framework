import interaction/application_command
import interaction/autocomplete
import interaction/message_component
import interaction/modal_submit
import interaction/ping

pub type Interaction {
  Ping(ping.Interaction)
  ApplicationCommand(application_command.Interaction)
  ApplicationCommandAutocomplete(autocomplete.Interaction)
  MessageComponent(message_component.Interaction)
  ModalSubmit(modal_submit.Interaction)
}
