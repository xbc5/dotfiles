return function()
  require('jumpwire').setup({ language = {
    ['test.ts'] = {
    implementation = { type = 'fileExtension', data = 'ts'},
    },
    ['ts'] = {
      test = { type = 'fileExtension', data = 'test.ts'},
    }
  }})
end
