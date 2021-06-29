// generate a random "stargate" name

private _letters = ['A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','X','X','X','X','Y', 'Z']; // yes, X is overrepresented, 'I' and 'O' removed
private _numbers = ['0','1','2','3','4','5','6','7','8','9'];
private _alphanum = _letters + _numbers;

private _name = "P" + 
                (selectRandom _numbers) + 
                (selectRandom _letters) + 
                "-" + 
                (selectRandom _numbers) +
                (selectRandom _alphanum) +
                (selectRandom _alphanum);

_name;
