// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require cavy/jquery
//= require jquery_ujs
//= require cavy/foundation

$(document).ready(function () {
    $(document).foundation();
});

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
        if ($(this).is('textarea')) {
            if (typeof CKEDITOR.instances[id] !== 'undefined') {
                CKEDITOR.instances[id].updateElement();
                CKEDITOR.instances[id].destroy();
            }
        }
        $('#'+id).hide();
    });

    if (input.is('textarea')) {
        CKEDITOR.replace(input.attr('id'), {
            language: 'en'
        });
    } else {
        input.show();
    }
};