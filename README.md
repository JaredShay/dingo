# Dingo

Dingo generates copy. Because you're a real aussie and are too lazy to write
your own.

It works by generating an infinite sequences of Australian flavoured copy.

## API

```
dingo = Dingo.new

dingo.words(4)
=> ["mateship", "Woolies", "marbo", "sicky"]

dingo.sentences(1)
=> ["Acca dacca wranga red hot go herald sun mullet qantas."]

dingo.paragraphs(1)
=> ["Underdog roy & hg sam newman slow internet sunburn 52 beers in one flight.
    Little people riding horses richie benaud true blue battered sav doll bludger qantas.
    Grand final the 7 30 report liking soccer when we're in the world cup shaun micaleff bruce mcavaney cobber.
    Don burke's beard one hand one bounce woolies burke & wills reversing the ute one handed roy & hg."]

dingo.people(4)
=> ["eddie mcguire", "bruce mcavaney", "thorpey", "shaun micaleff", "tony"]

dingo.emails(2)
=> ["adam.hills@sunburn.com.au", "gough.whitlam@pavlova.com.au"]
```

all of the above can also be called as class methods.

```
Dingo.words(1)
Dingo.sentences(1)
Dingo.paragraphs(1)
Dingo.people(1)
Dingo.emails(1)
```

## Configurables

```
Dingo.new(
  random: 12,
  source_words: ["Bush fires", "Resenting the monarchy"],
  source_people: ["Matey Cobber-Sheep", "Ragey McSportsdad"],
  sentence_length: 7,
  paragraph_length: 3
)
```
