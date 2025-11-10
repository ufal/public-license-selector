$ = require 'jquery'
_ = require 'lodash'
Tooltip = require '../core/tooltip'

EVENT_NS = 'license-selector'

Explanations =
  'the scope of copyright and related rights': """
<p>
Copyright protects original works. Originality is defined as the author’s own
intellectual creation. Therefore, mere statements of historical facts, results
of measurements etc. are not protected by copyright, because they exist
objectively and therefore cannot be <em>created</em>. The same applies to ideas,
mathematical formulas, elements of folklore etc. While quantitative data are
usually not protected by copyright, qualitative data (as their creation
involve some intellectual judgment) or language data are usually
copyrightable.
</p>
<p>
Apart from copyright in the data itself, a compilation of data (a dataset) may
also be protected by copyright as an original work. It is the case when the
selection and arrangement of the dataset involves some degree of intellectual
creation or choice. This is not the case when the guiding principle of the
collection is exhaustivity and/or completeness. For example, while <em>My
favorite works of William Shakespeare</em> will most likely be an original
collection, <em>Complete works of William Shakespeare</em> will not, as it leaves
no room for personal creativity.
</p>
<p>
The investment (of money and/or labor) into the making of the dataset is
irrelevant from the point of view of copyright law; however, a substantial
investment into the creation of a database may attract a specific kind of
protection, the sui generis database right. If your data and your dataset are
not original, but you made a substantial investment into the making of a
database, you can still benefit from legal protection (in such a case, answer
YES to this question).
</p>
<p>Answer <strong>Yes</strong> if ...</p>
<ul>
  <li>selecting a license for language data (in most cases)</li>
  <li>selecting a license for original (creative) selection or arrangement of the dataset</li>
  <li>substantial investment went into the making of the database</li>
  <li>you are not sure that the answer should be <strong>No</strong></li>
</ul>
<p>answer <strong>No</strong> if ...</p>
<ul>
  <li>your dataset contains only quantitative data and/or raw facts</li>
  <li>your dataset is exhaustive and complete (or at least aims to be)</li>
  <li>only if you are sure!</li>
</ul>
"""
  'copyright and similar rights': """
<p>
<strong>copyright</strong> &ndash; protects original works or original compilations of works
</p>
<p>
<strong>sui generis database rights</strong> &ndash; protects substantial investment into the making of a database
</p>
"""
  'licensed under a public license': """
<p>
By <em>licensed</em> data we understand data available under a public license, such
as Creative Commons or ODC licenses. If you have a bespoke license for the
data (i.e. a license drafted for a specific contractual agreement, such as
between a publisher and a research institution), contact our legal help desk.
</p>
"""
  'Public Domain': """
<p>
Public Domain is a category including works that are not protected by
copyright (such as raw facts, ideas) or that are no longer protected by
copyright (copyright expires 70 years after the death of the author). In many
jurisdictions, some official texts such as court decisions or statutes are
also regarded as part of the public domain.
</p>
"""
  'additional permission': """
<p>
In order to be able to deposit your data in our repository, you will have to
contact the copyright holder (usually the publisher or the author) and ask him
for a written permission to do so. Our legal help desk will help you draft the
permission. We will also tell you what to do if you cannot identify the
copyright holder.
</p>
"""
  'derivative works': """
<p>
Derivative works are works that are derived from or based upon an original
work and in which the original work is translated, altered, arranged,
transformed, or otherwise modified. This category does not include parodies.
</p>
<p>
Please note that the use of language resources consists of making derivative
works. If you do not allow others to build on your work, it will be of very
little use for the community.
</p>
"""
  'commercial use': """
<p>
Commercial use is a use that is primarily intended for or directed towards
commercial advantage or monetary compensation.
</p>
<p>
Please note that the meaning of this term is not entirely clear (although it
seems to be generally agreed upon that academic research, even carried out by
professional researchers, is not commercial use) and if you choose this
restriction, it may have a chilling effect on the re-use of your resource by
some projects (public-private partnerships).
</p>
"""
  'attribute': """
<p>
It is your moral right to have your work attributed to you (i.e. your name
mentioned every time someone uses your work). However, be aware of the fact
that the attribution requirement in Creative Commons licenses is more extended
than just mentioning your name.
</p>
<p>
In fact, the attribution clause in Creative Commons licenses obliges the user
to mention a whole set of information (identity of the creator, a copyright
notice, a reference to the chosen CC license and a hyperlink to its text, a
disclaimer of warranties, an indication of any modifications made to the
original work and even a hyperlink to the work itself). This may lead to a
phenomenon known as <em>attribution stacking</em>, which will make your work
difficult to compile with other works.
</p>
"""

ExplanationsTerms = _.keys(Explanations)

addExplanations = (text) ->
  for term in ExplanationsTerms
    index = text.indexOf(term)
    if ( index >= 0 )
      text = text.substring(0,index) +
        '<span class="ls-term">' +
        text.substring(index, index + term.length) +
        '</span>' + text.substring(index + term.length)
  return text

explanationTooltips = (scope, container) ->
  $('.ls-term', scope).each ->
    $el = $(this)
    term = $el.html()
    return unless Explanations[term]
    new Tooltip($('<div />').addClass('ls-term-tooltip').html(Explanations[term]), $el, {
      'container': container
      position: 'bottom'
    })
    return
  return


module.exports =
  EVENT_NS: EVENT_NS
  Explanations: Explanations
  ExplanationsTerms: ExplanationsTerms
  addExplanations: addExplanations
  explanationTooltips: explanationTooltips
