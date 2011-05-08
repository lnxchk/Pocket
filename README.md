# Pocket

An ad-hoc query caching plugin for Chef::Knife

## Preface

Cache the output of a knife search query for use in later knife ssh commands.  
If you are planning to run a number of commands across a set of hosts, and those
activities don't change the state of the hosts to the point that your host query
would change, don't take the time and resources to go back to the canonical source.

## What it does

knife pocket find 'somehost'
uses the expanded fuzzy searching from the knife grep example plugin 
http://www.opscode.com/blog/2011/04/22/chef-0-10-preview-knife-plugins-and-ui/

Writes the hostnames out to a file, all on one line, separated by spaces the way
knife ssh -m likes it.

The default file is .pocket in the current working directoy.

Specify your own file with -P FILE or --pocket FILE


knife pocket ssh 'command' 
runs the ssh command on each host saved in the .pocket file. Use -P FILE or --pocket FILE
to specify your own file.

## This is a mess, yo
This is my first foray into ruby.  Be nice. There's no nice error handling except what gets 
passed back up from the knife commands.  I'm not entirely certain that all of the options to 
knife ssh will work.  

And there appears to be some wacky inheritance problem that means I am requiring net/ssh/multi
explicitly.  I have no idea wtf is going on with that.

All the screen output is the same thing that comes back from the regular knife commands.
