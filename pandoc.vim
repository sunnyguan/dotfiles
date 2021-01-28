" Pandoc Settings

function! s:LiveEvent(job_id, data, event) dict
	if a:event ==? 'stderr'
		let str = 'Compile Error: '.join(a:data)
	elseif a:event ==? 'stdout'
		let str = 'Compile Output: '.join(a:data)
	else
		let str = 'Compilation Successful'
		silent execute "checktime"
	endif
	echo str
endfunction

let s:callbacks = {
			\ 'on_stdout': function('s:LiveEvent'),
			\ 'on_stderr': function('s:LiveEvent'),
			\ 'on_exit': function('s:LiveEvent')
			\ }

function! s:LiveCompile(command)
	let b:compile_job = jobstart(a:command, s:callbacks)
endfunction

function! EnablePandocLive()
    let b:pdf_filename = split(getcwd(), "/")[-1] . '.pdf'
    augroup PandocLive
        autocmd! * <buffer>
        autocmd BufWritePost <buffer> silent call s:LiveCompile('pandoc -f markdown *.md -o ' . b:pdf_filename . ' --template eisvogel --metadata-file ~/Desktop/markdown/2021_Spring/configs/meta.yaml --filter pandoc-latex-environment --listings')
    augroup END

    command -buffer PandocLiveDisable call s:DisablePandocLive()
    delcommand PandocLiveEnable
endfunction

function! EnablePandocLivePart()
    let b:pdf_filename = split(getcwd(), "/")[-1] . '_part.pdf'
    augroup PandocLivePart
        autocmd! * <buffer>
        autocmd BufWritePost <buffer> silent call s:LiveCompile('pandoc -f markdown ' . fnameescape(@%) . ' 0*.md -o ' . b:pdf_filename . ' --template eisvogel --metadata-file ~/Desktop/markdown/2021_Spring/configs/meta.yaml --metadata titlepage=false --filter pandoc-latex-environment --listings')
    augroup END

    command -buffer PandocLiveDisable call s:DisablePandocLive()
    delcommand PandocLiveEnable
endfunction


function! s:DisablePandocLive()
    augroup PandocLive
        autocmd! * <buffer>
    augroup END
    augroup! PandocLive
    delcommand PandocLiveDisable
    command! PandocLiveEnable call EnablePandocLive()
endfunction

function! s:DisablePandocLivePart()
    augroup PandocLivePart
        autocmd! * <buffer>
    augroup END
    augroup! PandocLivePart
    delcommand PandocLiveDisablePart
    command! PandocLiveEnablePart call EnablePandocLivePart()
endfunction


augroup PandocLive
    autocmd!
    autocmd Filetype pandoc,vimwiki,markdown nnoremap <leader>le :PandocLiveEnable<CR>
    autocmd Filetype pandoc,vimwiki,markdown nnoremap <leader>ld :PandocLiveDisable<CR>
    autocmd Filetype pandoc,vimwiki,markdown command! PandocLiveEnable call EnablePandocLive()
augroup END

augroup PandocLivePart
    autocmd!
    autocmd Filetype pandoc,vimwiki,markdown nnoremap <leader>pe :PandocLiveEnablePart<CR>
    autocmd Filetype pandoc,vimwiki,markdown nnoremap <leader>pd :PandocLiveDisablePart<CR>
    autocmd Filetype pandoc,vimwiki,markdown command! PandocLiveEnablePart call EnablePandocLivePart()
augroup END

augroup FiletypePairs
    autocmd!
    autocmd Filetype pandoc,markdown let b:AutoPairs = AutoPairsDefine({
                \ '\left(': ' \right)//k)',
                \ '$': '$',
                \ '$$': '$$',
                \ '{': '}',
                \ ':::': ':::'
                \ })
augroup END

let g:tex_flavor='latex'
