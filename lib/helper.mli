open Tokenizer

(** Prints a list of elements, separated by spaces. *)
val print_list : ('a -> string) -> 'a list -> unit

(** Prints a list of elements, separated by newlines. *)
val print_list_newline : ('a -> string) -> 'a list -> unit

(** Convert a key-value pair to a string *)
val key_value_pair_to_string : ('a -> string) -> int * 'a -> string

(** Convert a list of tokens to a string *)
val pp_tokens : token list -> string