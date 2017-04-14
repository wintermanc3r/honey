#Intro
I am currently trying to build up a list of resources from my HTTP logs that bots frequently request. To discover these resources, I comb my logs and google the URI's requested. Sometimes they can yield interesting results.

I discovered that many servers around the internet get hit frequently by these URI requests, and they change according to the date. The phpmyadmin requests were by far the most numerous resource requested, (in different permutations). For some of the less requested resources, I had to look through pages and pages of google results.

One of these resources lead me down a rabbit hole that lead me to...

## Tangent 1

While crawling the web, googling for logs that people leave available to the public, I came across an interesting thing: One website that had the <title>Mr Secretz Shell</title>. Naturally interested, I googled "Mr Secretz Shell" and found a number of defaced websites. Upon a little bit of investigation, they are an Indonesian hacker group called "Guarda Security Hacker", using a php-backdoor for some websites running vulnerable webservices. (I didn't look into which services were vulnerable.) 

One google result had a defacement on top of a defacement: http://agungsucipto.co.id/shop/cart/
This site turned up whe I googled "Mr Secretz Shell", but when investigated, was another defacement by a couple of Pakistani hacker groups, for the Pakistani Army, etc. Screenshots are included.

When googling the first hacker group, "Guarda Security Hacker" turned up these two links, (one to a github user account with the exploits)[https://github.com/Yukinoshita47/php-backdoor]

(and one with a guide about how to use them)[http://blog.garudasecurityhacker.org/2017/01/mr-secretz-shell-recoded-dari-shell.html]
