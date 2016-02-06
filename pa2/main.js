/*
 * https://stackoverflow.com/questions/8393636/node-log-in-a-file-instead-of-the-console
 * https://nodejs.org/api/stream.html#stream_event_readable
 * https://nodejs.org/api/fs.html#fs_fs_createreadstream_path_options
 */

var fs = require('fs');
var filename = process.argv[2];
var write_file = fs.createWriteStream(__dirname + "/" + filename + "-lex");

var readline = require('readline');
var rl = readline.createInterface({
	input: fs.createReadStream(__dirname + "/" + filename),
	terminal: false
});

console.log = function(str) {
  write_file.write(str + '\n');
};

function exec (input) {
     require("./lexer").parse(input);
}

raw = ""
rl.on('line', function(line) {
	raw += line;
	raw += '\n';
});

rl.on('close', function() {
	exec(raw);
});