import application_command_param.{type Param, type ParamDefinition}
import discord/entities/context.{type Context}
import discord/entities/integration_type.{type IntegrationType}
import discord/entities/interaction
import gleam/bool
import gleam/dict.{type Dict}
import gleam/list
import gleam/string
import response

pub opaque type ApplicationCommand(bot) {
  ChatInputCommand(
    CommandDefinition(bot),
    List(ParamDefinition(bot)),
    ParamsCommandHandler(bot),
  )
  ChatInputCommandTree(CommandDefinition(bot), List(CommandTreeNode(bot)))
  UserCommand(CommandDefinition(bot), CommandHandler(bot))
  MessageCommand(CommandDefinition(bot), CommandHandler(bot))
}

pub fn is_valid(command: ApplicationCommand(_)) -> Bool {
  case command {
    ChatInputCommand(def, ..) | ChatInputCommandTree(def, ..) ->
      is_valid_definition(def:) |> bool.and(!string.is_empty(def.description))

    UserCommand(def, ..) | MessageCommand(def, ..) -> is_valid_definition(def:)
  }
}

fn is_valid_definition(def definition: CommandDefinition(_)) {
  { !string.is_empty(definition.name) }
  |> bool.and(list.length(definition.contexts) > 0)
  |> bool.and(list.length(definition.integration_types) > 0)
}

pub type CommandDefinition(bot) {
  CommandDefinition(
    name: String,
    name_locales: List(#(String, String)),
    description: String,
    description_locales: List(#(String, String)),
    default_member_permissions: String,
    integration_types: List(IntegrationType),
    contexts: List(Context),
    nsfw: Bool,
  )
}

pub fn new_definition(
  name name: String,
  desc description: String,
  integs integration_types: List(IntegrationType),
  contexts contexts: List(Context),
) {
  CommandDefinition(
    name:,
    name_locales: [],
    description:,
    description_locales: [],
    default_member_permissions: "",
    integration_types:,
    contexts:,
    nsfw: False,
  )
}

pub fn chat_input_command(
  def def: CommandDefinition(bot),
  params params: List(ParamDefinition(bot)),
  handler handler: ParamsCommandHandler(bot),
) {
  ChatInputCommand(def, params, handler)
}

pub fn chat_input_tree_commands(
  def def: CommandDefinition(bot),
  commands sub_commands: List(CommandTreeNode(bot)),
) {
  ChatInputCommandTree(def, sub_commands)
}

pub opaque type CommandTreeNode(bot) {
  TreeNode(NodeDefinition, List(CommandTreeNode(bot)))
  TreeLeaf(
    NodeDefinition,
    List(ParamDefinition(bot)),
    ParamsCommandHandler(bot),
  )
}

pub type NodeDefinition {
  NodeDefinition(
    name: String,
    name_locales: List(#(String, String)),
    description: String,
    description_locales: List(#(String, String)),
  )
}

pub fn new_node_definition(name name: String, desc description: String) {
  NodeDefinition(name:, name_locales: [], description:, description_locales: [])
}

pub fn tree_node(
  def def: NodeDefinition,
  commands sub_commands: List(CommandTreeNode(_)),
) {
  TreeNode(def, sub_commands)
}

pub fn tree_leaf(
  def def: NodeDefinition,
  params params: List(ParamDefinition(bot)),
  handler handler: ParamsCommandHandler(bot),
) {
  TreeLeaf(def, params, handler)
}

pub fn user_command(
  def def: CommandDefinition(bot),
  handler handler: CommandHandler(bot),
) {
  UserCommand(def, handler)
}

pub fn message_command(
  def def: CommandDefinition(bot),
  handler handler: CommandHandler(bot),
) {
  MessageCommand(def, handler)
}

pub type CommandHandler(bot) =
  fn(interaction.ApplicationCommand, bot) -> CommandResponse

pub type ParamsCommandHandler(bot) =
  fn(interaction.ApplicationCommand, Dict(String, Param), bot) ->
    CommandResponse

pub opaque type CommandResponse {
  MessageWithSource(response.MessageWithSource)
  DeferredMessageWithSource(response.DeferredMessageWithSource)
  Modal(response.Modal)
}

pub fn reply_with_message(message) {
  MessageWithSource(response.MessageWithSource(message))
}

pub fn show_modal(modal) {
  Modal(response.Modal(modal))
}

/// TODO
pub fn deferred_message_reply(message) {
  DeferredMessageWithSource(response.DeferredMessageWithSource(message))
}
