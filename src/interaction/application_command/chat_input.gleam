import gleam/option.{type Option}
import interaction/application_command/command_option.{type CommandOption}
import resolved.{type Resolved}

pub type Interaction {
  CommandInteraction(
    name: String,
    resolved: Resolved,
    options: List(CommandOption),
    guild_id: Option(String),
    target_id: Option(String),
  )
}

pub type Command {
  Command
  CommandTree
}

pub type CommandTree {
  Node(Node)
  Leaf(Leaf)
}

pub type Node {
  CommandNode(sub_commands: List(CommandTree))
}

pub type Leaf {
  CommandLeaf
}
