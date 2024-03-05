{ pkgs, lib, config, ... }:

{
  options = {};
  config = {
    home.file.".config/Yubico/u2f_keys".text = ''
      bliztle:jT4IZih9hlRhC8BNgQaFepRVzc+RMHXlBPLsrmHL6dhWD+oOjWLgTvqRLE3XXehuQcT6Q3rxJSIIvLoZu0kNEQ==,6+sZO/eqcod02HgoSkaXTBeKhE7J5w2gqAKW7QGMsqf5UBEhqDmk4TZtgwwZ0cIAPu1xG2IsHQaufUjt5KyUtA==,es256,+presencebliztle:QnFLaMq1juVQ2yZvoeJWtJ7/i+duv8Pp38PgJDXARJVkV/iRMKGKbKHJ2ZPoBiVP7VbHhUNB0mZtYYZCuAJ9zA==,5h74UM3dRTkyMBo/2Gquwfh9pBvmPE6wbqIyIXHtUEkOHuPJwYqWTT8ZOZ28XRkJR1ZeehRhRI0QLA+zKSN9QA==,es256,+presence
    '';
  };
}
