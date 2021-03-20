# SetGame

![SetGame copy](https://user-images.githubusercontent.com/77430390/111865045-e3943880-8921-11eb-9ae6-ec46a2f75c8e.jpg) 

## Introduction
SetGame is a card game of pattern recognition based on a [real-time card game designed by Marsha Falco](https://en.wikipedia.org/wiki/Set_(card_game)#Basic_combinatorics_of_Set). 
The deck consists of 27 unique cards set out to 4x3 grid of face-up cards. The goal is to quickly find as many *sets* of three cards as possible, based on matches of three features:
- **Color** - Each card is either *pink*, *orange* or *blue*.
- **Shape** - Each card contains either an *oval*, *diamond* or *rectangle*.
- **Shading** - Each shape on each card is either *solid*, *striped* or *empty*.

A *set* consists of three cards in which **one** of the three categories of features - *color*, *shape*, and *shading* is either **the same** OR **all different**. Put another way: For each feature the three cards must avoid having two cards showing one version of the feature and the remaining card showing a different version.

## About the Project 
The application was created to memorize the material from Stanford University’s course [CS193p (Developing Applications for iOS using SwiftUI)](https://cs193p.sites.stanford.edu).

- ### Technologies 
     - **Swift 5**
     - **SwiftUI**
     - **MVVM**

- ### To Do
     - Store and update max score
     - Add difficulty levels

