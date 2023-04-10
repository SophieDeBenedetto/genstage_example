defmodule GenstageExample.ProducerConsumer do
  use GenStage

  require Integer

  def start_link(_initial) do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [{GenstageExample.Producer, max_demand: 10}]}
  end

  def handle_events(events, _from, state) do
    numbers =
      events
      |> Enum.filter(&Integer.is_even/1)

    {:noreply, numbers, state}
  end
end


# * producer starts
# * prodeucer consumer starts
# * consumer starts


# * producer consumer sends a request to the producer, demanding some numbers
# * producer calls handle_demand and responds with the list of numbers
# * producer consumer calls handle_events and filters the list of numbers and returns the filtered list
# * the consumer sends a request demanding data from the producer consumer
# * the producer consumer responds with the list of filtered numbers that it put in the tuple returned from
# handle_events
