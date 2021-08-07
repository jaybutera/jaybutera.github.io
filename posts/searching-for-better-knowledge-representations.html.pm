#lang pollen

◊(define-meta title "Searching For Better Knowledge Representations")
◊(define-meta published "2021-11-07")

The core tenet of functional programming is that something that changes is no longer considered the same thing. There are perspectives that reality works in this way. For instance, that each passing moment is a just a frame in space-time and perhaps even you are dying and being reborn in every moment. The useful feature of this perspective is that history is preserved perfectly and it is up to the observer how the state of what-is should be perceived.

I often am dissapointed in the lack of productivity in apps like Twitter. So much energy, so many thoughts and so much history is put into the app every day. Yet it is easily lost in time, whether that is due to it being removed or just being lost in the pile.

Imagine if our reality worked like it does in Twitter. When someone makes a statement that they later decide is wrong, and so remove it, they have effectively erased history. It’s not that they took back what they said – they literally never said it. Obviously our reality doesn’t work like that. The past is certainly up to interpretation but it can’t be redone. In Twitter it would make more sense that if someone wants to take back what they said, they have a standard way of placing an amendment on top of the original statement. And all comments from others about the original statement will not be nullified like they would if the comment were removed. Then I could go to Twitter and see that, “Ah yes, the president said this. Then he wanted to change that so he updated his point.” That sounds much more like the reality we live in.

Git is an example of a protocol that preserves history in this way. Each new commit describes additions and removals of the node its updating. As a user you can check out any commit and get the state of the project at that moment. But git would not make for a good foundation to a microblog. Not all thoughts are amendments or additions to previous thoughts. Sometimes new and independent chains of thoughts can open and close momentarily. On Twitter we see this when people reply to their own posts with numbered bullet points (e.g. 2/10, 3/10, ..).

Perhaps the model that more closely resembles this kind of open-play of ideas that build off eachother is a wiki (or more the more structured ◊(link "https://zettelkasten.de/introduction/" "zettelkasten")). In a wiki, the ability for a page to reference others is what makes the “web of knowledge” so powerful. Ideas strengthen eachother, new work can build off old work. Wikipedia manages to stay very contemporary with pages on currently happening events, while also storing event pages that happened ten years ago, and also historical accounts. All these pages are able to reference eachother. But in Wikipedia of course, information can be modified at any time. The relationships and opinions of documents is an everchanging battle. To combat this, projects like the Internet Archive have to continuously snapshot the entire Wikipedia so that we can instead inspect that and say, “ok this document said this at that time, but then changed its stance to this.” Effectively the same problem we run into on Twitter.

Interestingly, Wikipedia does track the revision history of each page. This is kind of like the git model of commits. When a page references another, it’s referencing the “head”, which points to the latest commit. So while individual document revisions are preserved, the history of relationships between these documents is lost due to having no concept of change in a reference itself.

What if we made the links reference a specific revision of a document instead? That is typically what we mean when we reference something. Typically we mean that thing and not some future potential state that the thing may evolve into. Of course the story of a web where nothing could be updated would be a pretty short one. And so we allow revisions, but references continue to refer to the original document. If we would like to update a reference from another page, just revise that page.

The immutable web is not a new concept. Something like this system could be implemented in the IPFS protocol. IPFS objects simply consist of some content (the data) and a list of links to other IPFS objects. Straight from the IPFS whitepaper:


◊code-block{
type IPFSObject struct {
    links []IPFSLink
    // array of links

    data []byte
    // opaque content data
}
}

The data is completely generic so we can see this as just any data and its immutable dependencies. The data could be an html web page where links in the html are listed in the ipfs object. The name of the document is just the hash of the data and links, so we don’t actually need the content of links to create this object; just the hashes.

Using the ipfs object model, you could imagine writing a simple parser/compiler which just scans an html file for all link <a> tags and if they are ipfs urls, adds them to the links of an ipfs document. A simple API to abstract over revising a document could just be a light wrapper over ipfs “create”, where the document being modified is referenced in the revision’s links.

◊code-block{
type Doc = (Hash, Vec<u8>, Vec<Hash>);

/// Add ‘doc’ as a link to the revised version.
/// Replace ‘doc’s contents with ‘content’.
/// Replace ‘doc’s links with ‘links’.
fn revise(doc: Hash, content: Vec<u8>, links: Vec<Hash>) → Doc;
}

There are probably better formats to match a broad scope of use cases like web/wiki/blog/social-network. Pollen is an interesting one where ipfs json objects could be generated directly from html, markdown, or whatever format with only annotations for the ipfs links.
