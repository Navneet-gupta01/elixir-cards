defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  """

  @doc """
  Create Deck. Returns List of Strings Representation of deck
  ## Examples

      iex> Cards.create_deck
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
       "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
       "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
       "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamond",
       "Two of Diamond", "Three of Diamond", "Four of Diamond", "Five of Diamond"]

  """

  def create_deck do
    values = ["Ace","Two","Three","Four","Five"]
    suits = ["Spades","Clubs","Hearts","Diamond"]
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Shuffle Deck Cards. Returns List of Suffled Strings Representation of deck cards
  """
  def shuffle (deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Check if a Card is in a particular deck.
  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck. The `take` argument inidcates how
  many cards should be in the hand
  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck,1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, take) do
    Enum.split(deck, take)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary ( deck )
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term ( binary )
      {:error, _reason} -> "Something went Wrong. Please check Input parameter."
    end
  end


  @doc """
  Create A Deck of set of cards ,Suffle it and create a hand of deck
  ## Examples

      iex> hand_size = 5
      iex> {hand, other} = Cards.create_hand(hand_size)
      iex> length(hand) == hand_size
      true
      iex> length(other) == (20-hand_size)
      true

  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal( hand_size )
  end
end
