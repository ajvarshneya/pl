/*
 * https://stackoverflow.com/questions/8393636/node-log-in-a-file-instead-of-the-console
 * https://nodejs.org/api/stream.html#stream_event_readable
 * https://nodejs.org/api/fs.html#fs_fs_createreadstream_path_options
 */

var fs = require('fs');
var filename = process.argv[2];

var read_file = fs.createReadStream(__dirname + "/" + filename);
var write_file = fs.createWriteStream(__dirname + "/" + filename + "-lex");

// Executes lexing
function lex (input) {
     require("./lexer").parse(input);
}

// Readable stream event
var raw = "";
read_file.on('readable', function () {
  var data;
  while (null !== (data = read_file.read())) {
  	raw += data;
  }
});

// Stream ends, lex input
read_file.on('end', function () {
	lex(raw);
});

// Override console.log for file
console.log = function(str) {
  write_file.write(str + '\n');
};