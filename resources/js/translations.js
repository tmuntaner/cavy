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

    let localeLabels = {};

    $('#' + labelsContainer + ' a').each(function () {
        let locale = $(this).data('locale');
        localeLabels[locale] = $(this);
    });

    $('#' + fieldsContainer + ' input, #' + fieldsContainer + ' textarea').each(function () {
        $(this).hide();
        if ($(this).attr('type') === 'file') {
            let picture = $('#' + $(this).data('picture'));
            picture.hide();
        }

        let locale = $(this).data('locale');
        let value = $(this).val();
        let label = localeLabels[locale];

        label.attr('data-input', $(this).attr('id'));
        $(this).attr('data-label', label.attr('id'));

        if (value === "") {
            translationFieldEmpty(localeLabels[locale]);
        }
        else {
            translationFieldFilled(localeLabels[locale]);
        }
    });
    let initialField = $('#' + id);
    localeLabels[initialField.data('locale')].addClass('active');
    if (initialField.attr('type') === 'file') {
        let picture = $('#' + initialField.data('picture'));
        picture.show();
        initialField.show();
    }
    else if (initialField.is('textarea')) {
        CKEDITOR.replace(id, {
            language: 'en'
        });
    } else {
        initialField.show();
    }
};

window.translationFieldChanged = function (input) {
    "use strict";

    let labelId = input.data('label');
    let label = $('#' + labelId);

    if (input.val() === '') {
        translationFieldEmpty(label);
    }
    else {
        translationFieldFilled(label);

    }
};

window.translationLabelClicked = function (label, fieldsContainer) {
    "use strict";

    let input = $('#' + label.data('input'));
    let labels = $('#' + label.data('labels'));

    labels.find('li a').removeClass('active');
    label.addClass('active');

    $('#' + fieldsContainer + ' input, #' + fieldsContainer + ' textarea').each(function () {
        $(this).hide();
        let id = $(this).attr('id');
        if ($(this).attr('type') === 'file') {
            let picture = $('#' + $(this).data('picture'));
            picture.hide();
        }
        if ($(this).is('textarea') && typeof CKEDITOR.instances[id] !== 'undefined') {
            CKEDITOR.instances[id].updateElement();
            CKEDITOR.instances[id].destroy();
        }
        $('#' + id).hide();
    });

    if (input.attr('type') === 'file') {
        let picture = $('#' + input.data('picture'));
        picture.show();
        input.show();
    } else if (input.is('textarea')) {
        CKEDITOR.replace(input.attr('id'), {
            language: 'en'
        });
    } else {
        input.show();
    }
};
