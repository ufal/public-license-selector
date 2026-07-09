$ = require 'jquery'
_ = require 'lodash'
Tooltip = require '../core/tooltip'

EVENT_NS = 'license-selector'

###
# Module: helpers/explanations.coffee
# Summary: Glossary support that wraps trigger terms and attaches tooltips with rich HTML.
###
Explanations =
  'copyright': """
<p>
For a dataset to be protected by copyright, it must be the unique result of the creative activity of a natural person, i.e. a human (not an artificial intelligence or a legal entity). Therefore, simple (quantitative) data measured by a machine will usually not be protected by copyright, since it exists objectively (it is not a result of creative activity). In contrast, qualitative data and/or linguistic data, which typically require intellectual activity to create, are usually protected by copyright. The dataset itself, or, more precisely, its structure (regardless of what the dataset contains), may also be protected by copyright if the way in which its contents are selected or arranged is the author's own intellectual creation.
</p>
<p>
If you are still not sure if your dataset is protected by copyright and/or special right of the database maker, click YES.
</p>
"""
  'special right of the database maker': """
<p>
Irrespective of whether the content or structure of the dataset is subject to copyright, your dataset may also be protected by a special right of the database maker, also known as SGDR. SGDR arises when a substantial contribution has been invested in the database, and this right serves primarily to protect such an investment (not necessarily financial, but also investment in personnel, time, etc.) of the database maker.
</p>
<p>
If you are still not sure if your dataset is protected by copyright and/or special right of the database maker, click YES.
</p>
"""
  'changes': """
<p>
If you choose "No", please understand that you are only entitled to license those parts of the dataset that are your own original work. Third-party content of the dataset has to remain under the original license. This must be clearly indicated (for ex. in a README/text file).
</p>
"""
  'derivative works': """
<p>
A derivative work is a work that is created by processing (e.g. alteration, translation, remixing) of another person's work, in this case by processing your dataset. However, if another person's work is merely included in the dataset without being changed in any way, such an inclusion does not constitute a derivative work.
</p>
"""
  'the same license': """
<p>
By the same license we mean the same license or a later version of the same license (e.g., a derivative work created by processing a dataset licensed under CC BY-SA 3.0 may be licensed under CC BY-SA 3.0 or CC BY-SA 4.0).
</p>
"""
  'commercially': """
<p>
"Commercial use" is a use that is primarily intended for or directed towards commercial advantage or monetary compensation.
</p>
<p>
Please note that the meaning of this term is not entirely clear (although it seems to be generally agreed upon that academic research, even carried out by professional researchers, is not commercial use) and if you choose this restriction, it may have a chilling effect on the re-use of your data by others, especially in public-private partnerships.
</p>
"""
  'public license': """
<p>
The most widely used public licenses are Creative Commons licenses. Simply put, public license is a licensing agreement that is concluded by the user beginning to behave in accordance with the terms of the public license attached to a work (i.e. there is no need to contact the licensor in order to use their work).
</p>
"""
  'additional permission': """
<p>
In order to be able to deposit and make the dataset available in the repository, you will have to contact the copyright holder (usually the author or the publisher) and obtain a written permission (license) to do so. If you have already obtained this permission/license, license the dataset accordingly.
</p>
"""
  'public domain': """
<p>
A work that enters the public domain is a work for which the period of the economic rights has expired (70 years after the death of the author, or in the case of co-authorship, 70 years after the death of the last surviving co-author). Such a work may be used by anyone without restriction.
</p>
<p>
Public domain might also include materials that are not subject to copyright protection, such as raw quantitative data and, depending on national legislation, legal texts or government documents.
</p>
"""
  # NOTE: docx highlights only 'use', but 'use' alone would create false matches in
  # CommercialUse ('use your data commercially') and other questions. 'use your code' is
  # unique to the Copyleft question and provides proper context.
  'use your code': """
<p>
By "use", we mean using your code for software development purposes rather than running the software itself. In most cases, this involves modifying your code, which constitutes the creation of a derivative work. However, some licenses, most notably the GNU GPL, apply even when the code is used without modifications as long as your software is incorporated into the final software.
</p>
"""
  'compatible open-source license': """
<p>
By compatible open-source license, we mean the licenses commonly known as copyleft licenses. If someone modifies your software, the modified software (or its part) must be released under the same license as your original software. This ensures that any improvements to the software remain open for widespread use.
</p>
"""
  # ORDERING NOTE: 'parts' must appear BEFORE 'part' in this object to prevent substring
  # matching conflicts in addExplanations(). The StrongCopyleft question contains "parts",
  # and we need 'parts' to match first before 'part' is considered.
  'parts': """
<p>
In this context a "part" refers to a file, library or other component that has been modified. With weak-copyleft licenses, the copyleft effect only applies to the modified parts and not to the entire software, unlike with strong copyleft licenses such as the GNU GPL.
</p>
"""
  'part': """
<p>
In this context a "part" refers to a file, library or other component. With weak-copyleft licenses, the copyleft effect only applies to the modified parts and not to the entire software, unlike with strong copyleft licenses such as the GNU GPL.
</p>
"""
  'larger work': """
<p>
A larger work is a software project that involves combining existing software with your own original code. This combination can occur through linking (either static or dynamic) or by including the third-party code in separate files within the same project. In that case, you are only licensing your own original code. Remember that you cannot relicense the existing software, and that you must comply with the terms of its license.
</p>
"""

ExplanationsTerms = _.keys(Explanations)

addExplanations = (text) ->
  terms = ExplanationsTerms.slice()
  terms.sort (a, b) -> b.length - a.length
  escapedTerms = (term.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') for term in terms)
  pattern = new RegExp(escapedTerms.join('|'), 'g')
  text.replace pattern, (match) -> "<span class=\"ls-term\">#{match}</span>"

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
