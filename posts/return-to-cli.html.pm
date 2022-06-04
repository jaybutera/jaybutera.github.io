#lang pollen

◊(define-meta published "2022-06-04")
◊(define-meta title "A Case For the Return to Command Line")

In this article I hope to help you see an alternative possible relationship
with the software we use. One where software is built more personally; like a
hand-crafted clock rather than a mass-manufactured shoe.

To see how this is possible, we'll look at the history of computing, going back
to AT&T Bell Labs. We'll also look at the modern software ecosystem, and the
differences between consumer-grade software, and the sort of "deep web" underbelly
of software that exists on GitHub; inacessible to the average user.

This is not a romanticization of the good ol' days of computing. There are very
practical reasons to investigate modern notions of user-interfaces. The modern
notion of software is that it is complex and requires teams of engineers to
design and constantly maintain throughout the life of the software.

Building an alternative web browser, one not based on Firefox or Chrome, is an
enormous task that would require a sustainable business to maintain. Similarly,
better collaboration tools than Google Drive or the alternatives like Cryptpad
are highly desirable but also require a team of engineers to manage.

Software has become complex and difficult to build and maintain. But there are
pockets of history where we can see a much more personal and useful evolution
of software shine through the muck. Bell Labs is a well known R&D branch of
AT&T which produced an uncanny amount of modern technology between the
1960-80s. To name a few, the transistor, information theory, the Unix operating
system (the foundation of Linux and MacOS), the C programming language,
cellular networks, the laser, and even the first evidence of the cosmic
microwave background radiation was accidently discovered at Bell Labs.

Within the computing department of Bell Labs alone, the majority of
foundational software tools used today, that are almost unnoticed when using a
computer, were built for internal use. One such tool was Bash - a text based
interactive environment to the operating system, aka "command line".

Researchers built their software to be used in bash. Everyone at Bell Labs as
well as the other branches of AT&T used software built by the researchers. For
instance the first application of Unix was an automation tool for AT&T patent
writers, who were submitting multiple patents a day.

This kind of tight-knit relationship between developers and users enabled a
rapid evolution of highly effective software. Software developers were building
software for their own use, and getting feedback from others using the software
as well. As a result the lab produced some of the finest quality software,
evidenced by its proliferant use today, more than half a century later.

The close relationship between development and use is certainly what enabled
the incredible pace of the lab to innovate. As another example, after the
compiler frontend Yacc was made, which is essentially a tool to automate
compiler design, others used it to make tools like the portable C
compiler, Make, and Roff. All of which are still commonly used today, including Yacc
itself.

It's worth noting here that just because software is old does not mean it is
less complex than modern-day software. In fact Unix is a response to
a long-standing bureaucratic operating system project called Multics. Multics
was heavily over engineered. It was a costly and time consuming project. After
finishing work on it, Ken Thompson reflected on what went wrong and built
Unix in three weeks.

We distinguish between quality software made in close connection with users and
software which is made to reach a vague and sweeping audience, likely for
reasons of profit, by calling them polytechnic and monotechnic software
respectively. These are terms coined by ◊(link
"https://postrev.wordpress.com/2009/07/09/technics/" "Lewis Mumford").

Back to the modern day, a similar caliber of a quality software ecosystem still
exists but it is hidden from most people. Such software is reserved only for
developers and "power" users that know how to use the command line. Using these
tools, seemingly difficult problems for most people today become easy.
Collaborating on documents without the use of a central server, sending large
files over the internet, and staying private in web interactions are all common
operations in polytechnic software.

The reason these tools only exist on command line is that building a graphical
interface for them would be a project in itself, likely just as complex or more
than the software itself. In order to reach all platforms at once, html on the
web is a common choice for a GUI. But choosing this route also ties the
software to the web paradigm which is an unhelpful abstraction for the
use cases just mentioned.

It is also an illusion that web apps work universally on all platforms.
Discrepancies between rendering in Firefox and Chrome, and even
different versions of the browser or different operating systems and devices
all have to be considered. The product becomes mediocre software which is complex to
maintain. A jack of all trades and master of none.

This is why some of the most useful software is crafted for command line. It
fits into an environment which has hardly changed since its conception many
decades ago. It can be composed with the other common tools in the command line
"toolbox" rather than being a one-off project which requires an entirely new
ecosystem to be built around it. And finally the environment is the same on all
systems.

This all saves time and energy for the developer, so that the focus is on the
actual logic and intention of the software. It is this ability to rapidly
iterate which closes the gap between developer and user. This is a tenet for
quality software which designs for users rather than vaguely at them. This is
the difference between polytechnic and monotechnics.

It is a common pattern today in small companies that the engineers design tools
for the "end user" who typically is outside the company. This is not
necessarily the case in large companies, like Google, which have many software
tools built for internal use.

In the small company, the business development team, marketing team, research
team, etc. are all not benefitting directly from the software produced by the
engineers. At best the teams benefit as much as anyone else who is using the
tools designed for the mass "end users", which as described before is often
mediocre compared to polytechnic software.

Furthermore you typically see that amongst the engineers they are sharing
software with one another and providing feedback, and building off eachothers work.

An organization which is able to engineer carefully curated software for its
needs through a tight feedback loop between development and use will be highly
effective. For such a team, software will become the means rather than the end.
That is, the software will support exponential progress in all focal points of a
project.

In order to produce and utilize polytechnic software, we have to reconsider the
users relationship with it. We must see software not necessarily as
something that is written once for everyone and then maintained, but instead
acknowledge that it is built in the context of an environment which dictates its
features. Usually that environment is a small team; a lab or company.

It is not the aim of polytechnic software to reach a large audience quickly,
although sometimes it does, like in the case of Unix. The goal is to serve the
needs of the environment.

Therefore we should not consider software to be a failure if not just anyone
can pick it up and use it right away (being "user friendly"). It only needs to
empower and serve the use cases in its environment. It is up to both the users
and the software to achieve that goal in a synergy rather than the software
extending until it is so universal that most of the features have been hidden
away and the software is bogged down in complexity.

Developing tools for the command line allows software to evolve rapidly, and
for the focus to be on the uses rather than appearances. The argument made here
for the benefits of command line have mostly been made from empirical data from
history and the modern open source ecosystem.

This is not to say that command line is necessarily the pinnacle of the polytechnic
software user experience. Only that historically and still today it is the most
effective way to make software usable and efficient.

There may be innovative solutions in the future which excel programmers and
users alike beyond the terminal. But for now the command line only needs to be
re-discovered, as the reasons for its usefulness have been forgotten by all but
the fringe users of software.
