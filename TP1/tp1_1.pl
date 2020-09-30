parent('AldoBurrows', 'LincolnBurrows').
parent('AldoBurrows', 'MichaelScofield').
parent('ChristinaRoseScofield', 'MichaelScofield').
parent('ChristinaRoseScofield', 'LincolnBurrows').
married('MichaelScofield', 'SaraTancredi').
married('LincolnBurrows', 'LisaRix').
parent('MichaelScofield', 'EllaScofield').
parent('LincolnBurrows', 'LJBurrows').
parent('SaraTancredi', 'EllaScofield').
parent('LisaRix', 'LJBurrows').

% a) parent(X, 'MichaelScofield'), parent(Y, 'MichaelScofield'), X\=Y.
% b) parent('AldoBurrows', X), parent('AldoBurrows', Y), X\=Y.


