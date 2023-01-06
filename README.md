# Pokedex!

## ATENTION: This Readme is still _incomplete_. More information will be added in the next few days.

## Documentation

- [Introduction](#introduction)
- [Installation](#installation)
- [Limitations](#limitations)
- [Pokémon API](#pokémon-api)
- [Demo](#demo)

## Introduction

Hi! This is a project about showing an interactive Pokedex in a mobile version. This project was created using [Flutter](https://flutter.dev/), [Dart](https://dart.dev/) and [PokéApi](https://pokeapi.co/) (free pókemon API).

## Installation

...

## Limitations

## 

## Pokémon API

This project uses the free [Pokémon API](https://pokeapi.co/) in order to get all the information about all Pokémons. If you want to know more, please check out the [API docs](https://pokeapi.co/docs/v2).

### Nested Nature

The Pokemon API used in this project has a **nested-link-nature**. This means this API provides us information about other API endpoints where there is more API endpoints to consume in order to get more information about everything related to Pokémons.

This is an example about the Nested Nature:

```json
// Info downloaded from 
// https://pokeapi.co/api/v2/pokemon?limit=15&offset=0
{
  "count": 1154,
  "next": "https://pokeapi.co/api/v2/pokemon?offset=2&limit=2",
  "previous": null,
  "results": [
    { 
        "name": "bulbasaur",
        // Below is another Endpoint 
        // to get more info about "bulbasaur"
        "url": "https://pokeapi.co/api/v2/pokemon/1/"
    },
    { 
        "name": "ivysaur",
        // Same as above 
        "url": "https://pokeapi.co/api/v2/pokemon/2/"
    },
    ...
  ]
}
```

### Issue with the Nested Nature

As you can see, we are consuming general information from Pokémons, but we are not getting specific information about the Pokémon rather than it's name and the other endpoint.

For this reason, if we want to get a list of Pokémons with their specific information, we need to consume the nested endpoints.

**For example:** If we want to get a list of 15 Pokémons with their details, we need to consume 16 endpoints (1 list Pokémon API + 15 specific Pokémon API).

The huge amount of endpoint calls results in a **_serious performance issue_** for a good UX/UI experience.

## Demo
