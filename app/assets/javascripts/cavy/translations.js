'use strict';

window.translationFieldEmpty = function (label) {
    "use strict";

    label.removeClass('filled');
    label.addClass('empty');
};

window.translationFieldFilled = function (label) {
    "use strict";

    label.addClass('filled');
    label.removeClass('empty');
};

window.initializeTranslationFields = function (fieldsContainer, labelsContainer, id) {
    "use strict";

    var localeLabels = {};

    $('#' + labelsContainer + ' a').each(function () {
        var locale = $(this).data('locale');
        localeLabels[locale] = $(this);
    });

    $('#' + fieldsContainer + ' input, #' + fieldsContainer + ' textarea').each(function () {
        $(this).hide();

        var locale = $(this).data('locale');
        var value = $(this).val();
        var label = localeLabels[locale];

        label.attr('data-input', $(this).attr('id'));
        $(this).attr('data-label', label.attr('id'));

        if (value === "") {
            translationFieldEmpty(localeLabels[locale]);
        } else {
            translationFieldFilled(localeLabels[locale]);
        }
    });
    var initialField = $('#' + id);
    localeLabels[initialField.data('locale')].addClass('active');
    if (initialField.is('textarea')) {
        CKEDITOR.replace(id, {
            language: 'en'
        });
    } else {
        initialField.show();
    }
};

window.translationFieldChanged = function (input) {
    "use strict";

    var labelId = input.data('label');
    var label = $('#' + labelId);

    if (input.val() === '') {
        translationFieldEmpty(label);
    } else {
        translationFieldFilled(label);
    }
};

window.translationLabelClicked = function (label, fieldsContainer) {
    "use strict";

    var input = $('#' + label.data('input'));
    var labels = $('#' + label.data('labels'));

    labels.find('li a').removeClass('active');
    label.addClass('active');

    $('#' + fieldsContainer + ' input, #' + fieldsContainer + ' textarea').each(function () {
        $(this).hide();
        var id = $(this).attr('id');
        if ($(this).is('textarea')) {
            if (typeof CKEDITOR.instances[id] !== 'undefined') {
                CKEDITOR.instances[id].updateElement();
                CKEDITOR.instances[id].destroy();
            }
        }
        $('#' + id).hide();
    });

    if (input.is('textarea')) {
        CKEDITOR.replace(input.attr('id'), {
            language: 'en'
        });
    } else {
        input.show();
    }
};