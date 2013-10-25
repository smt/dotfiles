$('a[title="Log Work on this Issue with Tempo"]')
    .closest('ul')
    .next()
    .addClass('aui-first')
    .end()
    .remove();

// swap epam logo with trollface
$('#logo').find('a').html(
    $('<img>')
    .attr('src', '//bit.ly/ghD24e')
    .css({'width': 'auto', 'height': '27px'})
);
