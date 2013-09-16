#!/bin/bash
 
for remote in evhan55 gnarf jugglinmike oconnore rwaldron bmac tafsiri
do
  git remote add $remote https://github.com/$remote/gaia.git
done
